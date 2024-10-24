#!/bin/bash

github=(
	icon=$GITHUB
	label="g || Github Web                                                          "
	label.drawing=on

)

system=(
	icon=$system
	label="p || System Pref"
	label.drawing=on
)

apps=(
	icon=$APPS
	label="a || App Launcher                                                                   "
	label.drawing=on
)

window=(
	icon=$WINDOW
	label="w || Window Management"
	label.drawing=on
)
chrome=(
	icon=$CHROME
	label="c || Chrome Profile Selector"
	label.drawing=on
)

iterm=(
	icon=$ITERM
	label="i || iTerm"
	label.drawing=on
)

cat=(
	icon=$CAT
	label="spacebar || Shortcat"
	label.drawing=on

)

stories=(
	icon=$BRANCH
	label="                   o ||                                   Shortcut Stories"
	label.drawing=on

)

sketchybar --add item app.menu left \
	\
	--add item github popup.app.menu \
	--set github "${github[@]}" \
	--add item apps popup.app.menu \
	--set apps "${apps[@]}" \
	--add item window popup.app.menu \
	--set window "${window[@]}" \
	--add item chrome popup.app.menu \
	--set chrome "${chrome[@]}" \
	--add item iterm popup.app.menu \
	--set iterm "${iterm[@]}" \
	--add item cat popup.app.menu \
	--set cat "${cat[@]}" \
	--add item system popup.app.menu \
	--set system "${system[@]}" \
	\
	--add item stories popup.app.menu \
	--set stories "${stories[@]}"
