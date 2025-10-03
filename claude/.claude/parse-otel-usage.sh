#!/bin/bash
# Parse OpenTelemetry metrics for token usage from Claude Code
# This will be called from the Stop hook

HASS_HOST="http://192.168.1.8:8123"
HASS_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2MjAwNTQwNDUwMDE0NDM2Yjk5MjJhMjk5MzhhYzMwNiIsImlhdCI6MTc1ODc5NjU1NiwiZXhwIjoyMDc0MTU2NTU2fQ.fU5j0lYPLsiMYejB0EHEFiphUd-9lwqa8PaISN4vcGY"

# Read hook input
HOOK_INPUT=$(cat)
TRANSCRIPT=$(echo "$HOOK_INPUT" | jq -r '.transcript_path // empty')

if [ -z "$TRANSCRIPT" ] || [ ! -f "$TRANSCRIPT" ]; then
    exit 0
fi

# Estimate token usage from transcript file size
# JSONL transcript includes JSON overhead, so adjust the estimation
CHAR_COUNT=$(wc -c < "$TRANSCRIPT" 2>/dev/null || echo "0")

# Better estimation:
# - ~3.5 chars per token on average
# - But JSONL has JSON structure overhead (brackets, quotes, keys)
# - Divide by 3 to account for this
TOKEN_ESTIMATE=$((CHAR_COUNT / 3))

# Use 200K as the session limit
SESSION_PCT=$((TOKEN_ESTIMATE * 100 / 200000))

# Cap at 100
if [ $SESSION_PCT -gt 100 ]; then
    SESSION_PCT=100
fi

# Update Home Assistant
curl -s -X POST \
    -H "Authorization: Bearer $HASS_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{
        \"state\": \"$SESSION_PCT\",
        \"attributes\": {
            \"unit_of_measurement\": \"%\",
            \"friendly_name\": \"Claude Usage (Current Session)\",
            \"icon\": \"mdi:brain\",
            \"token_estimate\": $TOKEN_ESTIMATE,
            \"otel_enabled\": true
        }
    }" \
    "$HASS_HOST/api/states/sensor.claude_usage_session" > /dev/null 2>&1

exit 0
