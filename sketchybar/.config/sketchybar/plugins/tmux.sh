#!/bin/bash

front_app=$(yabai -m query --windows --window | jq -r '.app')
window_title=$(yabai -m query --windows --window | jq -r '.title')
if [ "$SENDER" = "front_app_switched" ]; then
	if [ "$front_app" = "kitty" ]; then
		sketchybar --set tmux label="$window_title"
	fi
fi
