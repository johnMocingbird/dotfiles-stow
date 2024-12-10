#!/bin/bash

set -e # Exit on any error

# Install i3
echo "Downloading and installing i3 keyring..."
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2024.03.04_all.deb keyring.deb SHA256:f9bb4340b5ce0ded29b7e014ee9ce788006e9bbfe31e96c09b2118ab91fca734
sudo apt install ./keyring.deb
rm -f keyring.deb

echo "Adding i3 repository..."
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list

echo "Updating package lists..."
sudo apt update

echo "Installing i3..."
sudo apt install i3 -y

# Install dmenu
echo "Installing dmenu..."
sudo apt install dmenu -y

# Install tmux
echo "Installing tmux..."
sudo apt install tmux -y

# Install snapd
echo "Installing snapd..."
sudo apt install snapd -y

# Install Neovim via Snap
echo "Installing Neovim..."
sudo snap install nvim --classic

# Configure Neovim and Kitty
echo "Configuring Neovim and Kitty..."
rm -rf ~/.config/nvim/
stow nvim
stow kitty

echo "Installation complete!"
