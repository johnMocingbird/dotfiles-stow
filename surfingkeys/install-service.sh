#!/bin/bash

# SurfingKeys Server Installation Script for Ubuntu
# This script sets up the SurfingKeys config server as a systemd service

set -e  # Exit on any error

echo "🏄‍♂️ Installing SurfingKeys Config Server as a systemd service..."

# Check if running on Ubuntu/Debian
if ! command -v systemctl &> /dev/null; then
    echo "❌ Error: systemctl not found. This script requires a systemd-based system."
    exit 1
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Error: Node.js is not installed."
    echo "📥 Install Node.js first:"
    echo "   sudo apt update"
    echo "   sudo apt install nodejs npm"
    exit 1
fi

# Get current user and paths
CURRENT_USER=$(whoami)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVICE_FILE="surfingkeys.service"
SYSTEMD_DIR="/etc/systemd/system"

echo "📁 Script directory: $SCRIPT_DIR"
echo "👤 Current user: $CURRENT_USER"

# Check if server.js exists
if [ ! -f "$SCRIPT_DIR/server.js" ]; then
    echo "❌ Error: server.js not found in $SCRIPT_DIR"
    exit 1
fi

# Update the service file with current user and path
sed -i "s|User=john|User=$CURRENT_USER|g" "$SCRIPT_DIR/$SERVICE_FILE"
sed -i "s|Group=john|Group=$CURRENT_USER|g" "$SCRIPT_DIR/$SERVICE_FILE"
sed -i "s|WorkingDirectory=/home/john/dotfiles-stow/surfingkeys|WorkingDirectory=$SCRIPT_DIR|g" "$SCRIPT_DIR/$SERVICE_FILE"
sed -i "s|ReadWritePaths=/home/john/dotfiles-stow/surfingkeys|ReadWritePaths=$SCRIPT_DIR|g" "$SCRIPT_DIR/$SERVICE_FILE"

echo "✏️  Updated service file with current user and paths"

# Copy service file to systemd directory
echo "📋 Installing service file..."
sudo cp "$SCRIPT_DIR/$SERVICE_FILE" "$SYSTEMD_DIR/"

# Reload systemd daemon
echo "🔄 Reloading systemd daemon..."
sudo systemctl daemon-reload

# Enable the service to start on boot
echo "🚀 Enabling service to start on boot..."
sudo systemctl enable surfingkeys

# Start the service
echo "▶️  Starting SurfingKeys server service..."
sudo systemctl start surfingkeys

# Wait a moment for service to start
sleep 2

# Check service status
echo "📊 Service status:"
sudo systemctl status surfingkeys --no-pager

# Test if server is responding
echo ""
echo "🧪 Testing server connection..."
if curl -s "http://localhost:3030/status" > /dev/null; then
    LOCAL_IP=$(hostname -I | awk '{print $1}')
    echo "✅ SurfingKeys server is running successfully!"
    echo ""
    echo "🌐 Access URLs:"
    echo "   Local:   http://localhost:3030/surfingkeys"
    echo "   Network: http://$LOCAL_IP:3030/surfingkeys"
    echo ""
    echo "🔧 Service management commands:"
    echo "   sudo systemctl start surfingkeys     # Start service"
    echo "   sudo systemctl stop surfingkeys      # Stop service"
    echo "   sudo systemctl restart surfingkeys   # Restart service"
    echo "   sudo systemctl status surfingkeys    # Check status"
    echo "   sudo journalctl -u surfingkeys -f    # View logs"
else
    echo "⚠️  Service is running but server may not be responding on port 3030"
    echo "📋 Check logs: sudo journalctl -u surfingkeys -f"
fi

echo ""
echo "🎉 Installation complete!"