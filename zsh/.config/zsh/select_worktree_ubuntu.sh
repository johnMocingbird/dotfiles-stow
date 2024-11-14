#!/bin/bash

REPO_DIR="/home/john/mymoc.git" # Update this path if necessary
cd "$REPO_DIR" || exit 1

# List existing git worktrees
WORKTREES=$(git worktree list --porcelain | awk '/worktree/ {print $2}')

# Check if any worktrees are available
if [ -z "$WORKTREES" ]; then
	echo "No worktrees found." >&2
	exit 1
fi

# Use fzf to select a worktree
SELECTED_WORKTREE=$(echo "$WORKTREES" | fzf --height 10 --border --header="Select a git worktree")

# Check if a worktree was selected
if [ -z "$SELECTED_WORKTREE" ]; then
	echo "No worktree selected." >&2
	exit 1
fi

# Output the selected worktree path
echo "$SELECTED_WORKTREE"
