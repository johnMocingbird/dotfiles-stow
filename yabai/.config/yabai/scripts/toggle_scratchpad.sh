#!/bin/bash

app="$1"
scratchpad="$2"

# Launch app if it's not running
if ! pgrep -x "$app" >/dev/null; then
	open -a "$app"
	exit 0
fi

# Get IDs
focused_id=$(yabai -m query --windows --window | jq -r '.id')
match_id=$(yabai -m query --windows | jq -r --arg app "$app" '.[] | select(.app == $app and .scratchpad == "'"$scratchpad"'") | .id')

# If focused → hide
focused_app=$(yabai -m query --windows --window | jq -r '.app')
if [ "$focused_app" = "$app" ]; then
	yabai -m window --toggle "$scratchpad"
	exit 0
fi

# If not focused → focus it
if [ -n "$match_id" ]; then
	yabai -m window --focus "$match_id"
fi
