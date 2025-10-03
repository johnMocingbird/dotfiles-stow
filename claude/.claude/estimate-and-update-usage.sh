#!/bin/bash
# Estimate token usage from transcript and update HA
# Called from Stop hook

HASS_HOST="http://192.168.1.8:8123"
HASS_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2MjAwNTQwNDUwMDE0NDM2Yjk5MjJhMjk5MzhhYzMwNiIsImlhdCI6MTc1ODc5NjU1NiwiZXhwIjoyMDc0MTU2NTU2fQ.fU5j0lYPLsiMYejB0EHEFiphUd-9lwqa8PaISN4vcGY"

# Read hook input
HOOK_INPUT=$(cat)
TRANSCRIPT=$(echo "$HOOK_INPUT" | jq -r '.transcript_path // empty')

if [ -z "$TRANSCRIPT" ] || [ ! -f "$TRANSCRIPT" ]; then
    exit 0
fi

# Count conversation size (rough estimate)
CHAR_COUNT=$(wc -c < "$TRANSCRIPT" 2>/dev/null || echo "0")
# Rough estimate: 1 token ≈ 4 characters
TOKEN_ESTIMATE=$((CHAR_COUNT / 4))

# Use 400K as a more conservative estimate (transcripts include tool outputs, formatting, etc)
# This should give us a more accurate percentage
SESSION_PCT=$((TOKEN_ESTIMATE * 100 / 400000))

# Cap at 100
if [ $SESSION_PCT -gt 100 ]; then
    SESSION_PCT=100
fi

# Update only session usage (we can't estimate weekly)
curl -s -X POST \
    -H "Authorization: Bearer $HASS_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{
        \"state\": \"$SESSION_PCT\",
        \"attributes\": {
            \"unit_of_measurement\": \"%\",
            \"friendly_name\": \"Claude Usage (Current Session - Estimated)\",
            \"icon\": \"mdi:brain\",
            \"estimated\": true,
            \"token_estimate\": $TOKEN_ESTIMATE
        }
    }" \
    "$HASS_HOST/api/states/sensor.claude_usage_session" > /dev/null 2>&1

exit 0
