#!bin/bash

current_command="$1"
if [[ $current_command == "nvim" ]]; then
	tmux set-option -g status-position bottom
else
	tmux set-option -g status-position top
fi
