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

# Find the most recent assistant message with text content
ASSISTANT_UUID=$(tac "$TRANSCRIPT_PATH" | while IFS= read -r line; do
    if echo "$line" | grep -q '"role":"assistant"'; then
        TEXT=$(echo "$line" | jq -r '(.message.content[] | select(.type == "text") | .text) // empty' 2>/dev/null | head -1)
        if [ -n "$TEXT" ] && [ "$TEXT" != "null" ]; then
            echo "$line" | jq -r '.uuid'
            break
        fi
    fi
done)

if [ -z "$ASSISTANT_UUID" ]; then
    exit 0
fi

# Traverse up the parent chain to find the user message
CURRENT_UUID="$ASSISTANT_UUID"
USER_UUID=""
MAX_DEPTH=10
DEPTH=0

while [ $DEPTH -lt $MAX_DEPTH ]; do
    # Get the message with current UUID
    LINE=$(grep "\"uuid\":\"$CURRENT_UUID\"" "$TRANSCRIPT_PATH" | head -1)

    if [ -z "$LINE" ]; then
        break
    fi

    # Check if this is a user message
    ROLE=$(echo "$LINE" | jq -r '.message.role // empty')
    if [ "$ROLE" = "user" ]; then
        USER_UUID="$CURRENT_UUID"
        break
    fi

    # Get parent UUID
    PARENT_UUID=$(echo "$LINE" | jq -r '.parentUuid // empty')
    if [ -z "$PARENT_UUID" ]; then
        break
    fi

    CURRENT_UUID="$PARENT_UUID"
    DEPTH=$((DEPTH + 1))
done

if [ -z "$USER_UUID" ]; then
    exit 0
fi

# Get the user message content and check for #TTS
USER_MESSAGE=$(grep "\"uuid\":\"$USER_UUID\"" "$TRANSCRIPT_PATH" | jq -r '
    if .message.content | type == "string" then
        .message.content
    elif .message.content | type == "array" then
        (.message.content[] | select(.type == "text") | .text) // empty
    else
        empty
    end
' 2>/dev/null)

if ! echo "$USER_MESSAGE" | grep -q "#TTS"; then
    # No #TTS tag found, exit without speaking
    exit 0
fi

# Get the assistant response text
RESPONSE=$(grep "\"uuid\":\"$ASSISTANT_UUID\"" "$TRANSCRIPT_PATH" | jq -r '(.message.content[] | select(.type == "text") | .text) // empty' 2>/dev/null | head -1)

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
