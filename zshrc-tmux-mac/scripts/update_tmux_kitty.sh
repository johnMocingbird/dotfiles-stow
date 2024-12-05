#!/bin/bash
kitty @ set-window-title "$(tmux display-message -p '#S')"
sketchybar --set tmux label="$(tmux display-message -p '#S')"
