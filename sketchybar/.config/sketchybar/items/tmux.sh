#!/bin/bash

tmux_sess=(
	label.font="$FONT:Black:12.0"
	icon.background.drawing=on
	display=active
	script="$PLUGIN_DIR/tmux.sh"
	click_script="open -a 'Mission Control'"
)

sketchybar --add item tmux center \
	--set tmux "${tmux_sess[@]}" \
	--subscribe tmux front_app_switched
