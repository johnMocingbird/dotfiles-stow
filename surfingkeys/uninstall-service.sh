#!/bin/bash

# SurfingKeys Server Uninstall Script
# This script removes the SurfingKeys systemd service

set -e  # Exit on any error

echo "🗑️  Uninstalling SurfingKeys Config Server service..."

# Check if systemctl exists
if ! command -v systemctl &> /dev/null; then
    echo "❌ Error: systemctl not found. This script requires a systemd-based system."
    exit 1
fi

SERVICE_NAME="surfingkeys"
SERVICE_FILE="/etc/systemd/system/surfingkeys.service"

# Stop the service if running
echo "⏹️  Stopping service..."
if sudo systemctl is-active --quiet "$SERVICE_NAME"; then
    sudo systemctl stop "$SERVICE_NAME"
    echo "✅ Service stopped"
else
    echo "ℹ️  Service was not running"
fi

# Disable the service
echo "❌ Disabling service..."
if sudo systemctl is-enabled --quiet "$SERVICE_NAME"; then
    sudo systemctl disable "$SERVICE_NAME"
    echo "✅ Service disabled"
else
    echo "ℹ️  Service was not enabled"
fi

# Remove service file
if [ -f "$SERVICE_FILE" ]; then
    echo "🗂️  Removing service file..."
    sudo rm "$SERVICE_FILE"
    echo "✅ Service file removed"
else
    echo "ℹ️  Service file not found"
fi

# Reload systemd daemon
echo "🔄 Reloading systemd daemon..."
sudo systemctl daemon-reload

echo ""
echo "✅ SurfingKeys server service has been completely removed!"
echo "ℹ️  The server files are still in place and can be run manually with: node server.js"