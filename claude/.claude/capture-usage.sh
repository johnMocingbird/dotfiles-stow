#!/bin/bash
# Attempt to capture usage from interactive display

# Use script command to capture TUI output
OUTPUT=$(script -q /dev/null claude usage <<< $'\t' 2>/dev/null | head -20)

# Try to parse percentages from output
SESSION=$(echo "$OUTPUT" | grep -i "current session" | grep -oE '[0-9]+%' | head -1 | tr -d '%')
WEEK_ALL=$(echo "$OUTPUT" | grep -i "week.*all" | grep -oE '[0-9]+%' | head -1 | tr -d '%')
WEEK_OPUS=$(echo "$OUTPUT" | grep -i "week.*opus" | grep -oE '[0-9]+%' | head -1 | tr -d '%')

echo "Session: ${SESSION:-N/A}"
echo "Week (All): ${WEEK_ALL:-N/A}"
echo "Week (Opus): ${WEEK_OPUS:-N/A}"
