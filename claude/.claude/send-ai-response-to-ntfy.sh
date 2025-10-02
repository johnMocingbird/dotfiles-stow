#!/bin/bash
# Hook script to send AI response to ntfy.sh after Claude finishes responding
# This runs when the Stop event fires (after AI finishes)

# Read the hook input JSON from stdin
HOOK_INPUT=$(cat)

# Extract transcript_path from the JSON
TRANSCRIPT_PATH=$(echo "$HOOK_INPUT" | grep -o '"transcript_path":"[^"]*"' | cut -d'"' -f4)

if [ -z "$TRANSCRIPT_PATH" ]; then
    exit 0
fi

# Read the last assistant message from the JSONL transcript
# Each line is a JSON object, we want the last one with role: assistant
RESPONSE=$(tac "$TRANSCRIPT_PATH" | grep -m1 '"role":"assistant"' | jq -r '.message.content[0].text // empty' 2>/dev/null)

# Extract just text (remove code blocks and format for ntfy)
# Remove code blocks between ``` markers
CLEAN_RESPONSE=$(echo "$RESPONSE" | sed '/^```/,/^```/d')

# Remove markdown formatting
CLEAN_RESPONSE=$(echo "$CLEAN_RESPONSE" | sed 's/`//g' | sed 's/\*\*//g' | sed 's/__//g')

# Truncate to 400 chars for ntfy inline display
if [ ${#CLEAN_RESPONSE} -gt 400 ]; then
    CLEAN_RESPONSE="${CLEAN_RESPONSE:0:397}..."
fi

# Send to ntfy.sh with high priority
curl -s \
    -d "$CLEAN_RESPONSE" \
    -H "Title: AI Response Complete" \
    -H "Priority: 3" \
    -H "Tags: robot" \
    ntfy.sh/claude_ai > /dev/null 2>&1 &

# Play completion sound
afplay /System/Library/Sounds/Hero.aiff &

exit 0
