#!/bin/bash
# This script toggles the tmux prefix based on the current session name
# When in 'mymoc' session, unbind C-s so it passes to remote tmux
# In all other sessions, bind C-s as the local prefix

SESSION=$(tmux display-message -p '#S')

if [ "$SESSION" = "ubuntu-mymoc" ]; then
    # In mymoc session: unbind C-s so it passes through to remote tmux
    tmux unbind-key -n C-s 2>/dev/null
    tmux set-option prefix None
    tmux set-option prefix2 None
else
    # In other sessions: restore C-s as prefix
    tmux set-option prefix C-s
    tmux bind-key C-s send-prefix
fi
