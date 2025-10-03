#!/bin/bash

# Check if Angular dev server is running
ANGULAR_DIR="$HOME/development/frontend"
LOG_FILE="/tmp/angular-dev-server.log"
CLAUDE_STATE_FILE="/tmp/claude-state-angular"

# Get Claude status for this project
CLAUDE_STATUS="finished"
if [ -f "$CLAUDE_STATE_FILE" ]; then
  CLAUDE_STATUS=$(cat "$CLAUDE_STATE_FILE")
fi

# Check if npm run start-local process is running in the Angular directory
if pgrep -f "npm.*start-local" > /dev/null; then
  # Server is running, check the log file for status
  if [ -f "$LOG_FILE" ]; then
    # Check recent log entries for status
    LAST_LINES=$(tail -n 20 "$LOG_FILE")

    # Check for errors
    if echo "$LAST_LINES" | grep -qi "error\|failed"; then
      sketchybar --trigger angular_update STATUS=error CLAUDE_STATUS="$CLAUDE_STATUS"
    # Check if compiled successfully
    elif echo "$LAST_LINES" | grep -qi "compiled successfully\|local:.*http\|webpack.*compiled"; then
      sketchybar --trigger angular_update STATUS=ready CLAUDE_STATUS="$CLAUDE_STATUS"
    # Check if building/compiling
    elif echo "$LAST_LINES" | grep -qi "compiling\|building"; then
      sketchybar --trigger angular_update STATUS=building CLAUDE_STATUS="$CLAUDE_STATUS"
    else
      # Assume ready if process is running but no recent compilation messages
      sketchybar --trigger angular_update STATUS=ready CLAUDE_STATUS="$CLAUDE_STATUS"
    fi
  else
    # No log file, but process is running - assume starting
    sketchybar --trigger angular_update STATUS=starting CLAUDE_STATUS="$CLAUDE_STATUS"
  fi
else
  # Server is not running
  sketchybar --trigger angular_update STATUS=stopped CLAUDE_STATUS="$CLAUDE_STATUS"
fi
