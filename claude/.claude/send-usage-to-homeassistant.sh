#!/bin/bash
# Hook script to send Claude usage statistics to Home Assistant
# Runs after each response (Stop event)

# Home Assistant configuration
HASS_HOST="http://192.168.1.8:8123"
HASS_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2MjAwNTQwNDUwMDE0NDM2Yjk5MjJhMjk5MzhhYzMwNiIsImlhdCI6MTc1ODc5NjU1NiwiZXhwIjoyMDc0MTU2NTU2fQ.fU5j0lYPLsiMYejB0EHEFiphUd-9lwqa8PaISN4vcGY"

# Read hook input
HOOK_INPUT=$(cat)

# Log the full hook input for debugging (optional - uncomment to see what data is available)
# echo "$HOOK_INPUT" > /tmp/claude-hook-debug.json

# Try to extract usage information from the hook input
# The Stop hook should contain usage stats in the JSON payload
CURRENT_SESSION=$(echo "$HOOK_INPUT" | jq -r '.usage.current_session_percentage // empty' 2>/dev/null)
CURRENT_WEEK_ALL=$(echo "$HOOK_INPUT" | jq -r '.usage.current_week_all_percentage // empty' 2>/dev/null)
CURRENT_WEEK_OPUS=$(echo "$HOOK_INPUT" | jq -r '.usage.current_week_opus_percentage // empty' 2>/dev/null)

# Alternative: Parse from CLI output
# If usage isn't in hook input, we'll need to call claude CLI to get it
if [ -z "$CURRENT_SESSION" ]; then
    # Get usage stats from claude usage command
    USAGE_OUTPUT=$(claude usage 2>/dev/null || echo "")

    # Parse the output (we'll need to adjust this based on actual output format)
    # For now, using placeholder parsing - we'll test and adjust
    CURRENT_SESSION=$(echo "$USAGE_OUTPUT" | grep -i "current session" | grep -oE '[0-9]+%' | head -1 | tr -d '%')
    CURRENT_WEEK_ALL=$(echo "$USAGE_OUTPUT" | grep -i "current week.*all" | grep -oE '[0-9]+%' | head -1 | tr -d '%')
    CURRENT_WEEK_OPUS=$(echo "$USAGE_OUTPUT" | grep -i "current week.*opus" | grep -oE '[0-9]+%' | head -1 | tr -d '%')
fi

# Default to 0 if we couldn't get the values
CURRENT_SESSION=${CURRENT_SESSION:-0}
CURRENT_WEEK_ALL=${CURRENT_WEEK_ALL:-0}
CURRENT_WEEK_OPUS=${CURRENT_WEEK_OPUS:-0}

# Send to Home Assistant as sensor states
# We'll create 3 sensors: claude_usage_session, claude_usage_week_all, claude_usage_week_opus

update_sensor() {
    local entity_id=$1
    local state=$2
    local friendly_name=$3

    curl -s -X POST \
        -H "Authorization: Bearer $HASS_TOKEN" \
        -H "Content-Type: application/json" \
        -d "{
            \"state\": \"$state\",
            \"attributes\": {
                \"unit_of_measurement\": \"%\",
                \"friendly_name\": \"$friendly_name\",
                \"icon\": \"mdi:brain\"
            }
        }" \
        "$HASS_HOST/api/states/sensor.$entity_id" > /dev/null 2>&1
}

# Update all sensors
update_sensor "claude_usage_session" "$CURRENT_SESSION" "Claude Usage (Session)"
update_sensor "claude_usage_week_all" "$CURRENT_WEEK_ALL" "Claude Usage (Week - All Models)"
update_sensor "claude_usage_week_opus" "$CURRENT_WEEK_OPUS" "Claude Usage (Week - Opus)"

exit 0
