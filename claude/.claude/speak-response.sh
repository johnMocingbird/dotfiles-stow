#!/bin/bash
# Hook script to speak AI responses aloud when user includes #TTS in their prompt
# This runs when the Stop event fires (after AI finishes)

# Read the hook input JSON from stdin
HOOK_INPUT=$(cat)

# Extract transcript_path from the JSON
TRANSCRIPT_PATH=$(echo "$HOOK_INPUT" | grep -o '"transcript_path":"[^"]*"' | cut -d'"' -f4)

if [ -z "$TRANSCRIPT_PATH" ]; then
    exit 0
fi

# Small delay to ensure transcript is written to disk
# Longer delay for some projects which need it
if echo "$TRANSCRIPT_PATH" | grep -q "dotfiles\|front-end"; then
    sleep 2.5
else
    sleep 0.3
fi

# Find the most recent user message with #TTS
USER_WITH_TTS=$(tac "$TRANSCRIPT_PATH" | while IFS= read -r line; do
    if echo "$line" | grep -q '"role":"user"'; then
        TEXT=$(echo "$line" | jq -r '
            if .message.content | type == "string" then
                .message.content
            elif .message.content | type == "array" then
                (.message.content[] | select(.type == "text") | .text) // empty
            else
                empty
            end
        ' 2>/dev/null)

        if echo "$TEXT" | grep -q "#TTS"; then
            UUID=$(echo "$line" | jq -r '.uuid')
            echo "DEBUG: Found user with #TTS: $UUID" >> /tmp/tts_debug.log
            echo "DEBUG: User message: ${TEXT:0:100}" >> /tmp/tts_debug.log
            echo "$UUID"
            break
        fi
    fi
done)

if [ -z "$USER_WITH_TTS" ]; then
    echo "DEBUG: No user message with #TTS found" >> /tmp/tts_debug.log
    exit 0
fi

# Now find the FIRST assistant message that comes AFTER this user message (chronologically)
# Read the file in order and find the first assistant after our user message
FOUND_USER=false
ASSISTANT_UUID=$(cat "$TRANSCRIPT_PATH" | while IFS= read -r line; do
    UUID=$(echo "$line" | jq -r '.uuid // empty' 2>/dev/null)

    # Check if this is our user message
    if [ "$UUID" = "$USER_WITH_TTS" ]; then
        FOUND_USER=true
        continue
    fi

    # After finding the user message, look for the next assistant message
    if [ "$FOUND_USER" = true ]; then
        ROLE=$(echo "$line" | jq -r '.message.role // empty' 2>/dev/null)
        if [ "$ROLE" = "assistant" ]; then
            TEXT=$(echo "$line" | jq -r '(.message.content[] | select(.type == "text") | .text) // empty' 2>/dev/null | head -1)
            if [ -n "$TEXT" ] && [ "$TEXT" != "null" ]; then
                echo "DEBUG: Found assistant response: $UUID" >> /tmp/tts_debug.log
                echo "DEBUG: Response preview: ${TEXT:0:50}" >> /tmp/tts_debug.log
                echo "$UUID"
                break
            fi
        fi
    fi
done)

if [ -z "$ASSISTANT_UUID" ]; then
    echo "DEBUG: No assistant response found for user message" >> /tmp/tts_debug.log
    exit 0
fi

# Get the assistant response text
RESPONSE=$(grep "\"uuid\":\"$ASSISTANT_UUID\"" "$TRANSCRIPT_PATH" | jq -r '(.message.content[] | select(.type == "text") | .text) // empty' 2>/dev/null)

if [ -z "$RESPONSE" ]; then
    exit 0
fi

# Clean up the response for speaking
# Remove code blocks between ``` markers
CLEAN_RESPONSE=$(printf '%s' "$RESPONSE" | sed '/^```/,/^```/d')

# Remove markdown formatting
CLEAN_RESPONSE=$(printf '%s' "$CLEAN_RESPONSE" | sed 's/`//g' | sed 's/\*\*//g' | sed 's/__//g')

# Remove ALL newlines and convert to spaces
CLEAN_RESPONSE=$(printf '%s' "$CLEAN_RESPONSE" | tr '\n' ' ' | tr '\r' ' ' | sed 's/  */ /g' | sed 's/^ *//;s/ *$//')

# Only truncate if extremely long (over 3000 chars)
if [ ${#CLEAN_RESPONSE} -gt 3000 ]; then
    CLEAN_RESPONSE="${CLEAN_RESPONSE:0:2997}..."
fi

# Speak the response in background
if [ -n "$CLEAN_RESPONSE" ]; then
    # Log for debugging
    echo "TTS Length: ${#CLEAN_RESPONSE}" >> /tmp/tts_debug.log
    echo "TTS Text: ${CLEAN_RESPONSE:0:100}..." >> /tmp/tts_debug.log

    # Write to file and use that
    TMP_FILE="/tmp/claude_tts_speech.txt"
    printf '%s' "$CLEAN_RESPONSE" > "$TMP_FILE"

    # Use say with -f to read from file
    say -v Samantha -f "$TMP_FILE" &
fi

exit 0
