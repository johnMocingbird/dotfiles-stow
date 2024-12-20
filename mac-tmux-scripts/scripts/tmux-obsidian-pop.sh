#!/bin/bash
if [ "$(tmux display-message -p -F "#{session_name}")" = "obsidian" ]; then
	tmux detach-client || true
else
	tmux popup -KER "tmux attach -t obsidian || tmux new -s obsidian" || true
fi
exit 0
