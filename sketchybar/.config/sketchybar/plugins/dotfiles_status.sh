#!/bin/bash

# Check if current tmux window is in dotfiles directory
CLAUDE_STATE_FILE="/tmp/claude-state-dotfiles"

# Get Claude status for this project
CLAUDE_STATUS="finished"
if [ -f "$CLAUDE_STATE_FILE" ]; then
  CLAUDE_STATUS=$(cat "$CLAUDE_STATE_FILE")
fi

# Get the current pane's working directory from tmux
if command -v tmux >/dev/null 2>&1; then
	# Get the current pane's path
	CURRENT_DIR=$(tmux display-message -p -F "#{pane_current_path}" 2>/dev/null)

	# Check if we're in the dotfiles directory
	if echo "$CURRENT_DIR" | grep -q "dotfiles"; then
		sketchybar --trigger dotfiles_update STATUS=active CLAUDE_STATUS="$CLAUDE_STATUS"
	else
		sketchybar --trigger dotfiles_update STATUS=stopped CLAUDE_STATUS="$CLAUDE_STATUS"
	fi
else
	# tmux not available
	sketchybar --trigger dotfiles_update STATUS=stopped CLAUDE_STATUS="$CLAUDE_STATUS"
fi
