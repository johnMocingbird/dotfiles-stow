#!/bin/bash
# This script toggles the tmux prefix based on the current session name
# When in 'mymoc' or 'ubuntu_mymoc' sessions, unbind keys so they pass to remote tmux
# In all other sessions, bind C-s as the local prefix

SESSION=$(tmux display-message -p '#S')

if [ "$SESSION" = "mymoc" ] || [ "$SESSION" = "ubuntu_mymoc" ] || [ "$SESSION" = "remote_mymoc" ]; then
    # In remote sessions: unbind all keys so they pass through to remote tmux
    tmux unbind-key -n C-s 2>/dev/null
    tmux unbind-key -n C-a 2>/dev/null
    tmux unbind-key -n C-h 2>/dev/null
    tmux unbind-key -n C-j 2>/dev/null
    tmux unbind-key -n C-k 2>/dev/null
    tmux unbind-key -n C-l 2>/dev/null
    tmux unbind-key -n 'C-\' 2>/dev/null
    tmux set-option prefix None
    tmux set-option prefix2 None
else
    # In other sessions: restore C-s as prefix and all navigation keys
    tmux set-option prefix C-s
    tmux bind-key C-s send-prefix
    tmux bind-key -n C-a run-shell '/Users/john/dotfiles-stow/mac-tmux-scripts/scripts/toggle-ai-split'

    # Restore vim-tmux-navigator bindings
    is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?\$'"
    tmux bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
    tmux bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
    tmux bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
    tmux bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'
    tmux bind-key -n 'C-\\' if-shell "$is_vim" 'send-keys C-\\' 'select-pane -l'
fi
