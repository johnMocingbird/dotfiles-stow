#!/bin/bash

# display-message "#{pane_current_command}"
# tmux display -p '#{pane_current_command}'

current_command=$(tmux display -p '#{pane_current_command}')
if [[ "$current_command" == "nvim" ]]; then
	tmux set-option -g status-position top
fi

if [[ "$current_command" == "tmux" ]]; then
	tmux set-option -g status-position bottom
fi
