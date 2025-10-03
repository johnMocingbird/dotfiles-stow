#!/bin/bash
# Update Claude AI state for sketchybar indicator per project
# Usage: ./update-claude-state.sh <running|waiting|finished>

STATE=$1

if [ -z "$STATE" ]; then
	exit 1
fi

# Detect which project we're in based on tmux pane path
PROJECT="unknown"
if command -v tmux >/dev/null 2>&1; then
	CURRENT_DIR=$(tmux display-message -p -F "#{pane_current_path}" 2>/dev/null)

	# Determine project based on directory
	if echo "$CURRENT_DIR" | grep -q "development/front-end"; then
		PROJECT="angular"
	elif echo "$CURRENT_DIR" | grep -q "backend\|rails\|mymoc"; then
		PROJECT="rails"
	elif echo "$CURRENT_DIR" | grep -q "dotfiles"; then
		PROJECT="dotfiles"
	fi
fi

# Write state to project-specific file
STATE_FILE="/tmp/claude-state-${PROJECT}"
echo "$STATE" > "$STATE_FILE"

# Trigger sketchybar update for the specific project
if command -v sketchybar >/dev/null 2>&1; then
	case "$PROJECT" in
		"angular")
			sketchybar --trigger angular_update CLAUDE_STATUS="$STATE"
			;;
		"rails")
			sketchybar --trigger rails_update CLAUDE_STATUS="$STATE"
			;;
		"dotfiles")
			sketchybar --trigger dotfiles_update CLAUDE_STATUS="$STATE"
			;;
	esac
fi

exit 0
