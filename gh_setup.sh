#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status

# Install wget if not already installed
if ! type -p wget >/dev/null; then
	echo "Installing wget..."
	sudo apt update
	sudo apt-get install wget -y
fi

# Install GitHub CLI
echo "Installing GitHub CLI..."

(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) &&
	sudo mkdir -p -m 755 /etc/apt/keyrings &&
	wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null &&
	sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg &&
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
	sudo apt update &&
	sudo apt install gh -y

sudo apt update
sudo apt install gh

# Authenticate with GitHub CLI
echo "Please authenticate with GitHub CLI..."
gh auth login

# Generate SSH key
KEY_PATH="$HOME/.ssh/id_ed25519"
if [ ! -f "$KEY_PATH" ]; then
	echo "Generating a new SSH key..."
	ssh-keygen -t ed25519 -C "john.coakley@mocingbird.com"
else
	echo "SSH key already exists at $KEY_PATH."
fi

# Add SSH key to GitHub
echo "Adding SSH key to your GitHub account..."
gh ssh-key add "${KEY_PATH}.pub" --type authentication

# Test SSH connection to GitHub
echo "Testing SSH connection to GitHub..."
ssh -T git@github.com

echo "Setup complete!"
