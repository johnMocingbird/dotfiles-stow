#!/bin/bash

# The UUID of the vertical monitor
VERTICAL_MONITOR_UUID="81D9F5F3-2525-4796-A73A-BF8F02CE86E7"

# The name of the vertical sketchybar instance
VERTICAL_BAR_NAME="sketchybar_vertical"

# The path to the vertical sketchybar configuration file
VERTICAL_CONFIG_FILE="/Users/john/dotfiles-stow/sketchybar/.config/sketchybar/sketchybarrc_vertical"

# Check if the vertical monitor is connected
if yabai -m query --displays | grep -q "$VERTICAL_MONITOR_UUID"; then
  # If the monitor is connected, check if the vertical bar is running
  if ! sketchybar --query items | grep -q "$VERTICAL_BAR_NAME"; then
    # If the bar is not running, start it
    sketchybar --config "$VERTICAL_CONFIG_FILE" &
  fi
else
  # If the monitor is not connected, check if the vertical bar is running
  if sketchybar --query items | grep -q "$VERTICAL_BAR_NAME"; then
    # If the bar is running, stop it
    sketchybar --remove "$VERTICAL_BAR_NAME"
  fi
fi
