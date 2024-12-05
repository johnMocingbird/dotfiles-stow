#!/bin/bash

# Get the window ID of the most recently opened window

window_id=$(yabai -m query --windows | jq -r '[.[] | select(.app == "Kitty") | sort_by(.display, .space, .frame.w, .frame.h, .frame.x, .frame.y)] | .[-1].id')

# Specify your desired window dimensions
window_width=340
window_height=450

# Get the display dimensions and convert them to integers
screen_width=$(yabai -m query --displays --display | jq '.frame.w' | cut -d '.' -f 1)
screen_height=$(yabai -m query --displays --display | jq '.frame.h' | cut -d '.' -f 1)

# Calculate the position to center the window
pos_x=$(((screen_width - window_width) / 2))
pos_y=$(((screen_height - window_height) / 2))
# Set the window to float
yabai -m window $window_id --toggle float
# Resize and position the window
yabai -m window $window_id --resize abs:$window_width:$window_height
yabai -m window $window_id --move abs:$pos_x:$pos_y
# Optional delay

# Options
options=("Screenshots" "Downloads" "Movies" "Home" "iCloud")
selected=0

# Function to display the menu
display_menu() {
	echo "Select a directory (x to exit):"
	for i in "${!options[@]}"; do
		if [[ $i -eq $selected ]]; then
			echo "> ${options[$i]}"
		else
			echo "  ${options[$i]}"
		fi
	done
}

# Handle user input
while true; do
	clear
	display_menu
	read -n 1 -s key

	case $key in
	j) ((selected < ${#options[@]} - 1)) && ((selected++)) ;;
	k) ((selected > 0)) && ((selected--)) ;;
	'') break ;; # Enter key
	x) exit 0 ;; # Exit key
	esac
done

clear

# Act on the selection
case $selected in
0) nnn ~/Screenshots/ ;;
1) nnn ~/Downloads/ ;;
2) nnn ~/Movies/ ;;
3) nnn ~/. ;;
4) nnn ~/Library/Mobile Documents/com~apple~CloudDocs/ ;;
esac
