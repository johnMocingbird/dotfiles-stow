#!/bin/bash

# Check if the current window is floating
is_floating=$(yabai -m query --windows --window | jq '.floating == 1')

if [ "$is_floating" == "true" ]; then
	# If the window is already floating, toggle float to unfloat it
	yabai -m window --toggle float
else
	# If the window is not floating, toggle float and set it to 80% width centered
	yabai -m window --toggle float
	yabai -m window --grid 1:10:1:0:8:1
fi
