#!/bin/bash

# W I N D O W  M O D E
function window_mode() {
	echo "W I N D O W  M O D E"

	# C O L O R S
	# . $HOME/.cache/wal/colors.sh;

	# Y A B A I
	# yabai -m config active_window_border_color 0xff${color3:1}
	# yabai -m config normal_window_border_color 0xff${color3:1}
	# yabai -m config insert_feedback_color 0xff${color3:1}

	# S K E T C H Y B A R
	sketchybar -m --set apple icon.color="0xFF83A1F1"
	sketchybar -m --set apple icon="􀏝"

	# sketchybar -m --bar color=0xF0${color3:1}
	# sketchybar -m --default label.color=0xFF${foreground:1}
	# sketchybar -m --default icon.color=0xFF${background:1}
}

function normal_mode() {
	echo "normal_mode"

	sketchybar -m --set apple icon.color="0xFFA9B1D6"
	sketchybar -m --set apple icon="􀣺"
}

function leader_mode() {
	echo "leader_mode"

	sketchybar -m --set apple icon.color="0xFF00FF00"
	sketchybar -m --set apple icon="􁁺"
	# sketchybar --set apple popup.drawing=true
	sketchybar --trigger skhd_mode MODE="leader_mode"

}

function resize_mode() {
	echo "leader_mode"

	sketchybar -m --set apple icon.color="0xFF83A1F1"
	sketchybar -m --set apple icon="􁺠"
}

function disabled_mode() {
	echo "leader_mode"

	sketchybar -m --set apple icon.color="0xFFFF0000"
	sketchybar -m --set apple icon="􀃃"
}

function system_mode() {
	echo "leader_mode"

	sketchybar -m --set apple icon.color="0xFF83A1F1"
	sketchybar -m --set apple icon="􀍟"
}

# Main entry point: Check if a function name was provided as an argument
if [[ $# -lt 1 ]]; then
	echo "Usage: $0 <function_name>"
	exit 1
fi

# modes
# system_mode
# 􀙇 wifi
# 􀊰 Input
# output 􀟶
# Desktop icon toggle 􀣰
# Hidden files finder toggle 􀣍
# Pods conntect 􀪷

# window node
# left
# down
# up
# right
### insert
# 􂧭 top
# 􂮡 bottom
# left 􂧮
# right 􂬏

# Call the function passed as the first argument
"$1"
