#!/bin/bash

# Get the window name from tmux
WINDOW_NAME=$(tmux display-message -p '#W')
WINDOW_ID=$(tmux display-message -p '#I')

# Run commands based on window name
case "$WINDOW_NAME" in
    neovim)
        tmux send-keys -t "$WINDOW_ID" "nvim ." Enter
        ;;
    ai_cli)
        tmux send-keys -t "$WINDOW_ID" "claude" Enter
        ;;
    lazy_git)
        tmux send-keys -t "$WINDOW_ID" "lazygit" Enter
        ;;
    *)
        # Do nothing for other window names
        ;;
esac
