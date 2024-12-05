#!/bin/bash

# Query all windows managed by Yabai, display in FZF, and focus the selected window
yabai -m query --windows |
	jq -r '.[] | "\(.app) | \(.title) | \(.id)"' |
	fzf --prompt="Select a window: " |
	awk -F "|" '{print $3}' |
	xargs -I {} yabai -m window --focus {}
