#!/bin/bash

# Function to get icon for app name
get_app_icon() {
    local app_name=$(echo "$1" | tr '[:upper:]' '[:lower:]')

    case "$app_name" in
        *chrome*|*"google chrome"*) echo "" ;;
        *firefox*) echo "" ;;
        *safari*) echo "" ;;
        *arc*) echo "" ;;
        *brave*) echo "󰖟" ;;
        *edge*) echo "" ;;
        *code*|*"visual studio code"*) echo "󰨞" ;;
        *cursor*) echo "󰆾" ;;
        *zed*) echo "󰘦" ;;
        *neovim*|*nvim*) echo "" ;;
        *vim*) echo "" ;;
        *terminal*) echo "" ;;
        *kitty*) echo "󰄛" ;;
        *iterm*) echo "" ;;
        *alacritty*) echo "" ;;
        *wezterm*) echo "" ;;
        *finder*) echo "" ;;
        *spotify*) echo "" ;;
        *music*) echo "" ;;
        *discord*) echo "󰙯" ;;
        *slack*) echo "" ;;
        *telegram*) echo "" ;;
        *messages*) echo "󰍦" ;;
        *whatsapp*) echo "" ;;
        *notion*) echo "󰈚" ;;
        *obsidian*) echo "󱓷" ;;
        *figma*) echo "" ;;
        *sketch*) echo "" ;;
        *photoshop*) echo "" ;;
        *illustrator*) echo "" ;;
        *mail*) echo "" ;;
        *calendar*) echo "" ;;
        *notes*) echo "󱞎" ;;
        *reminders*) echo "" ;;
        *1password*) echo "" ;;
        *xcode*) echo "" ;;
        *github*) echo "" ;;
        *docker*) echo "" ;;
        *postman*) echo "󱂛" ;;
        *zoom*) echo "󰒯" ;;
        *facetime*) echo "" ;;
        *chatgpt*) echo "󰭹" ;;
        *home*assistant*) echo "󰟐" ;;
        *shortcut*) echo "󱓞" ;;
        *stream*deck*) echo "󰐌" ;;
        *system*preferences*|*system*settings*) echo "" ;;
        *) echo "" ;;
    esac
}

# Query all windows managed by Yabai, add icons, display in FZF, and focus the selected window
yabai -m query --windows |
	jq -r '.[] | "\(.app) | \(.title) | \(.id)"' |
	while IFS='|' read -r app title id; do
		app=$(echo "$app" | xargs)  # trim whitespace
		title=$(echo "$title" | xargs)
		id=$(echo "$id" | xargs)
		icon=$(get_app_icon "$app")
		echo "$icon $app | $title | $id"
	done |
	fzf --prompt="Select a window: " --ansi |
	awk -F "|" '{print $3}' |
	xargs -I {} yabai -m window --focus {}
