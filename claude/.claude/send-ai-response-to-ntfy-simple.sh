#!/bin/bash
# Simplified ntfy hook - sends AI response notification

set -euo pipefail

LOG="/tmp/ntfy.log"
exec 2>>"$LOG"

# Parse hook input with jq
HOOK_INPUT=$(cat)
TRANSCRIPT_PATH=$(echo "$HOOK_INPUT" | jq -r '.transcript_path // empty')

[[ -z "$TRANSCRIPT_PATH" ]] && exit 0

# Wait for transcript to be written (with timeout)
for i in {1..10}; do
    [[ -f "$TRANSCRIPT_PATH" ]] && break
    sleep 0.2
done

# Get last assistant response
RESPONSE=$(tac "$TRANSCRIPT_PATH" | \
    jq -rs 'map(select(.message.role == "assistant")) | .[0] |
    .message.content[0].text // empty')

[[ -z "$RESPONSE" ]] && exit 0

# Clean and truncate for ntfy
CLEAN=$(echo "$RESPONSE" | \
    sed '/^```/,/^```/d' | \
    sed 's/`//g; s/\*\*//g; s/__//g')

[[ ${#CLEAN} -gt 400 ]] && CLEAN="${CLEAN:0:397}..."

# Send notification
echo "[$(date)] Sending notification" >> "$LOG"
curl -s \
    -d "$CLEAN" \
    -H "Title: AI Response Complete" \
    -H "Priority: 3" \
    -H "Tags: robot" \
    ntfy.sh/claude_ai &>/dev/null &

# Play sound
afplay /System/Library/Sounds/Hero.aiff &

exit 0
