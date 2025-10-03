#!/bin/bash
# Manually update Claude usage in Home Assistant
# Run this after checking `claude usage`

HASS_HOST="http://192.168.1.8:8123"
HASS_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2MjAwNTQwNDUwMDE0NDM2Yjk5MjJhMjk5MzhhYzMwNiIsImlhdCI6MTc1ODc5NjU1NiwiZXhwIjoyMDc0MTU2NTU2fQ.fU5j0lYPLsiMYejB0EHEFiphUd-9lwqa8PaISN4vcGY"

echo "Enter Claude usage values (just the number, no % sign):"
read -p "Current session: " SESSION
read -p "Week (All Models): " WEEK_ALL
read -p "Week (Opus): " WEEK_OPUS

# Update sensors
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

update_sensor "claude_usage_session" "$SESSION" "Claude Usage (Current Session)"
update_sensor "claude_usage_week_all" "$WEEK_ALL" "Claude Usage (Week - All Models)"
update_sensor "claude_usage_week_opus" "$WEEK_OPUS" "Claude Usage (Week - Opus)"

echo "✓ Updated Home Assistant sensors:"
echo "  - Session: ${SESSION}%"
echo "  - Week (All): ${WEEK_ALL}%"
echo "  - Week (Opus): ${WEEK_OPUS}%"
