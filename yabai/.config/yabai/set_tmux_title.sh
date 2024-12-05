#!/bin/bash
window_info=$(yabai -m query --windows --window)
app_name=$(echo "$window_info" | jq -r '.app')
window_title=$(echo "$window_info" | jq -r '.title')

if [ "$app_name" = "kitty" ]; then
	sketchybar --set tmux label="$window_title"
else
	sketchybar --set tmux label=""
fi
