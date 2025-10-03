#!/bin/bash
# Manually update Claude usage stats to Home Assistant
# Can be run on-demand or via cron

HASS_HOST="http://192.168.1.8:8123"
HASS_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2MjAwNTQwNDUwMDE0NDM2Yjk5MjJhMjk5MzhhYzMwNiIsImlhdCI6MTc1ODc5NjU1NiwiZXhwIjoyMDc0MTU2NTU2fQ.fU5j0lYPLsiMYejB0EHEFiphUd-9lwqa8PaISN4vcGY"

# Function to update a sensor
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
                \"icon\": \"mdi:brain\",
                \"last_updated\": \"$(date -u +"%Y-%m-%dT%H:%M:%S")\"
            }
        }" \
        "$HASS_HOST/api/states/sensor.$entity_id" > /dev/null 2>&1
}

# Since we can't easily parse the interactive usage display,
# we'll use placeholder values for now
# You can manually update these after checking usage, or we can parse from another source

# For now, create the sensors with 0 values
# TODO: Find a way to programmatically get usage data
update_sensor "claude_usage_session" "1" "Claude Usage (Current Session)"
update_sensor "claude_usage_week_all" "1" "Claude Usage (Week - All Models)"
update_sensor "claude_usage_week_opus" "0" "Claude Usage (Week - Opus)"

echo "Sensors updated in Home Assistant"
echo "Check: http://192.168.1.8:8123/developer-tools/state"
