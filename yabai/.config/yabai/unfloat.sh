#!/bin/bash

# List of applications to unfloat
apps_to_unfloat=("Safari" "Arc" "Terminal" "kitty" "Alacritty" "Slack" "ChatGPT")

# Query all windows and unfloat those that match the apps and are currently floating
yabai -m query --windows | jq -c '.[]' | while read -r window; do
	app_name=$(echo "$window" | jq -r '.app')
	window_id=$(echo "$window" | jq '.id')
	is_floating=$(echo "$window" | jq '.["is-floating"]')

	# If the window belongs to one of the target apps and is floating, unfloat it
	if [[ "$is_floating" == "true" && " ${apps_to_unfloat[*]} " == *" $app_name "* ]]; then
		yabai -m window "$window_id" --toggle float
		echo "Unfloated window $window_id of $app_name"
	fi
done
