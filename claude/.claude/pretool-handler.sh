#!/bin/bash
# PreToolUse hook handler
# Sets Claude state to "waiting" (yellow) when tool is about to be used
# Optionally plays sound for important tools that need attention

# Read hook input
HOOK_INPUT=$(cat)

# Update state to waiting (yellow dot)
~/.claude/update-claude-state.sh waiting

# Optional: Play sound only for specific tool types that need user attention
# Uncomment and customize based on your needs:
#
# # Extract tool name from hook input (requires jq)
# TOOL_NAME=$(echo "$HOOK_INPUT" | jq -r '.tool_name // empty' 2>/dev/null)
#
# # Play sound only for specific tools (e.g., Bash commands)
# if [[ "$TOOL_NAME" == "Bash" ]]; then
#     afplay /System/Library/Sounds/Sosumi.aiff &
# fi

# For now, no sound - just update the indicator
# If you want sound for all tool uses, uncomment:
# afplay /System/Library/Sounds/Sosumi.aiff &

exit 0
