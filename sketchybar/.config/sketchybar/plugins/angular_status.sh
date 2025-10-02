#!/bin/bash

# Check if Angular dev server is running
ANGULAR_DIR="$HOME/development/frontend"
LOG_FILE="/tmp/angular-dev-server.log"

# Check if npm run start-local process is running in the Angular directory
if pgrep -f "npm.*start-local" > /dev/null; then
  # Server is running, check the log file for status
  if [ -f "$LOG_FILE" ]; then
    # Check recent log entries for status
    LAST_LINES=$(tail -n 20 "$LOG_FILE")

    # Check for errors
    if echo "$LAST_LINES" | grep -qi "error\|failed"; then
      sketchybar --trigger angular_update STATUS=error
    # Check if compiled successfully
    elif echo "$LAST_LINES" | grep -qi "compiled successfully\|local:.*http\|webpack.*compiled"; then
      sketchybar --trigger angular_update STATUS=ready
    # Check if building/compiling
    elif echo "$LAST_LINES" | grep -qi "compiling\|building"; then
      sketchybar --trigger angular_update STATUS=building
    else
      # Assume ready if process is running but no recent compilation messages
      sketchybar --trigger angular_update STATUS=ready
    fi
  else
    # No log file, but process is running - assume starting
    sketchybar --trigger angular_update STATUS=starting
  fi
else
  # Server is not running
  sketchybar --trigger angular_update STATUS=stopped
fi
