#!/bin/bash

# Navigate to your repository
cd ~/mydots-stow/ || return

# Check if we're on the main branch
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$CURRENT_BRANCH" != "main" ]; then
	echo "Not on the main branch. Aborting."
	return 0
fi

# Check for uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
	echo "You have local changes. Please commit or stash them before pulling."
	return 0
fi

# Get the number of commits on the remote main branch using gh CLI
REMOTE_COMMITS=$(gh repo view your-repo --json defaultBranchRef --jq '.defaultBranchRef.target.history.totalCount')

# Get the number of commits in the local main branch
LOCAL_COMMITS=$(git rev-list --count HEAD)

# If remote has more commits, pull the changes
if [ "$REMOTE_COMMITS" -gt "$LOCAL_COMMITS" ]; then
	echo "New commits found on remote. Pulling changes..."
	git pull origin main
else
	echo "Your repository is up to date."
fi
