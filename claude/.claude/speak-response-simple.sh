#!/bin/bash
# Simplified TTS hook - speaks AI responses when user message contains #TTS

set -euo pipefail

LOG="/tmp/tts.log"
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

# Check if last user message has #TTS tag
HAS_TTS=$(tac "$TRANSCRIPT_PATH" | \
    jq -rs 'map(select(.message.role == "user")) | .[0] |
    (.message.content | if type == "string" then . else (.[0].text // "") end) |
    contains("#TTS")')

[[ "$HAS_TTS" != "true" ]] && exit 0

# Get last assistant response
RESPONSE=$(tac "$TRANSCRIPT_PATH" | \
    jq -rs 'map(select(.message.role == "assistant")) | .[0] |
    .message.content[0].text // empty')

[[ -z "$RESPONSE" ]] && exit 0

# Clean response for TTS
CLEAN=$(echo "$RESPONSE" | \
    sed '/^```/,/^```/d' | \
    sed 's/`//g; s/\*\*//g; s/__//g' | \
    tr '\n' ' ' | \
    sed 's/  */ /g; s/^ *//; s/ *$//')

# Truncate if very long
[[ ${#CLEAN} -gt 3000 ]] && CLEAN="${CLEAN:0:2997}..."

# Speak in background
if [[ -n "$CLEAN" ]]; then
    echo "[$(date)] Speaking ${#CLEAN} chars" >> "$LOG"
    printf '%s' "$CLEAN" > /tmp/claude_tts.txt
    say -v Samantha -f /tmp/claude_tts.txt &
fi

exit 0
