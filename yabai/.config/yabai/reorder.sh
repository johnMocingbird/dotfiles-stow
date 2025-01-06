#!/bin/bash

# Desired order of apps
desired_order=("Arc" "kitty" "ChatGPT")

# Query the current windows
windows=$(yabai -m query --windows)

# Extract the first matching window ID for each desired app
arc_id=$(echo "$windows" | jq -r '.[] | select(.app == "Arc") | .id // empty' | head -n 1)
kitty_id=$(echo "$windows" | jq -r '.[] | select(.app == "kitty") | .id // empty' | head -n 1)
chatgpt_id=$(echo "$windows" | jq -r '.[] | select(.app == "ChatGPT") | .id // empty' | head -n 1)

# Debugging: Print extracted IDs
echo "Arc ID: $arc_id"
echo "Kitty ID: $kitty_id"
echo "ChatGPT ID: $chatgpt_id"

# Reorder windows
if [ -n "$arc_id" ]; then
	yabai -m window "$arc_id" --warp first
fi

if [ -n "$chatgpt_id" ]; then
	yabai -m window "$chatgpt_id" --warp last
fi

if [ -n "$arc_id" ]; then
	yabai -m window "$arc_id" --warp first
fi

if [ -n "$chatgpt_id" ]; then
	yabai -m window "$chatgpt_id" --warp last
fi

echo "Reordered windows: Arc -> Kitty -> ChatGPT"
