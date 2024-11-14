#!/bin/bash

# SSH into the Ubuntu machine and run 'select_worktree.sh' to select the worktree
SELECTED_WORKTREE=$(ssh -t -i /Users/john/.ssh/ubuntu_id_rsa john@192.168.50.75 'bash -l -c "~/select_worktree.sh"')

# Clean up the output (remove carriage returns and line breaks)
SELECTED_WORKTREE=$(echo "$SELECTED_WORKTREE" | tr -d '\r' | sed '/^$/d')

# Check if the selection was successful
if [ -z "$SELECTED_WORKTREE" ]; then
	echo "No worktree selected."
	exit 1
fi

echo "Selected worktree: $SELECTED_WORKTREE"

# Export the selected worktree as an environment variable
export WORKTREE_DIR="$SELECTED_WORKTREE"

# Start the Tmuxinator session
tmuxinator start mymoc
