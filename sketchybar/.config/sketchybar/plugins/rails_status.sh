#!/bin/bash

# Check if Rails dev server is running
LOG_FILE="/tmp/rails-dev-server.log"
CLAUDE_STATE_FILE="/tmp/claude-state-rails"

# Get Claude status for this project
CLAUDE_STATUS="finished"
if [ -f "$CLAUDE_STATE_FILE" ]; then
  CLAUDE_STATUS=$(cat "$CLAUDE_STATE_FILE")
fi

# Check if Puma (Rails server) is running
if pgrep -f "puma.*tcp://localhost:3000" > /dev/null; then
  # Server is running - default to green/ready
  STATUS="ready"

  # Only check logs for errors if log file exists
  if [ -f "$LOG_FILE" ]; then
    # Check last 10 lines for syntax errors or boot failures
    if tail -n 10 "$LOG_FILE" | grep -qi "error\|exception\|failed"; then
      STATUS="error"
    # Check if booting
    elif tail -n 10 "$LOG_FILE" | grep -qi "booting\|starting"; then
      STATUS="booting"
    fi
  fi

  sketchybar --trigger rails_update STATUS=$STATUS CLAUDE_STATUS="$CLAUDE_STATUS"
else
  # Server is not running - hide the indicator
  sketchybar --trigger rails_update STATUS=stopped CLAUDE_STATUS="$CLAUDE_STATUS"
fi
