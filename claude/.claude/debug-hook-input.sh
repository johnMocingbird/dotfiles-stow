#!/bin/bash
# Debug script to see what data is available in Stop hook

HOOK_INPUT=$(cat)
echo "$HOOK_INPUT" | jq '.' > /tmp/claude-stop-hook-debug.json
echo "Hook input saved to /tmp/claude-stop-hook-debug.json"

# Also print keys available
echo "$HOOK_INPUT" | jq 'keys' > /tmp/claude-stop-hook-keys.json

exit 0
