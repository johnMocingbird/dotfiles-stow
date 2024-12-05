#!/bin/bash
yabai -m query --windows |
	jq -r '.[] | "\(.app) | \(.title) | \(.id)"' |
	fzf --prompt="Select a window: " |
	awk -F "|" '{print $3}' |
	xargs -I {} yabai -m window --focus {}
