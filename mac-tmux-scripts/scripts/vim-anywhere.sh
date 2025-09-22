#!/usr/bin/env bash
# clipedit: Open clipboard text in a temp file with Neovim inside Alacritty.
# On quit, copies back to clipboard and closes the terminal window.

set -euo pipefail

# Create a one-off session script that runs INSIDE Alacritty
SESSION_SCRIPT="$(mktemp -t clipedit-session.XXXXXX.sh 2>/dev/null || mktemp /tmp/clipedit-session.XXXXXX.sh)"
chmod +x "$SESSION_SCRIPT"

cat >"$SESSION_SCRIPT" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

# Detect clipboard tools (inside the spawned terminal)
get_clip() {
  if command -v pbpaste >/dev/null 2>&1; then
    pbpaste
  elif [ -n "${WAYLAND_DISPLAY-}" ] && command -v wl-paste >/dev/null 2>&1; then
    wl-paste
  elif command -v xclip >/dev/null 2>&1; then
    xclip -selection clipboard -o
  elif command -v xsel >/dev/null 2>&1; then
    xsel --clipboard --output
  else
    echo "No clipboard read tool found (pbpaste/wl-paste/xclip/xsel)." >&2
    exit 1
  fi
}

set_clip() {
  if command -v pbcopy >/dev/null 2>&1; then
    pbcopy
  elif [ -n "${WAYLAND_DISPLAY-}" ] && command -v wl-copy >/dev/null 2>&1; then
    wl-copy
  elif command -v xclip >/dev/null 2>&1; then
    xclip -selection clipboard -in
  elif command -v xsel >/dev/null 2>&1; then
    xsel --clipboard --input
  else
    echo "No clipboard write tool found (pbcopy/wl-copy/xclip/xsel)." >&2
    exit 1
  fi
}

TMPFILE="$(mktemp -t clipedit.XXXXXX 2>/dev/null || mktemp /tmp/clipedit.XXXXXX)"
trap 'rm -f "$TMPFILE"' EXIT

# Pre-fill from clipboard
get_clip > "$TMPFILE" || true

# Edit
nvim "$TMPFILE"
NVIM_STATUS=$?

# Push back to clipboard
cat "$TMPFILE" | set_clip

# Self-clean and exit with nvim status
exit "$NVIM_STATUS"
EOF

# Decide how to launch Alacritty with the session script
launch_alacritty() {
	if command -v alacritty >/dev/null 2>&1; then
		exec alacritty \
			--class ClipEdit \
			--title "clipboard-edit" \
			--command bash -lc "$SESSION_SCRIPT"
	fi

	case "$OSTYPE" in
	darwin*)
		exec open -na "Alacritty" --args \
			--class ClipEdit \
			--title "clipboard-edit" \
			--command bash -lc "$SESSION_SCRIPT"
		;;
	*)
		echo "alacritty not found in PATH." >&2
		exit 1
		;;
	esac
}

launch_alacritty
