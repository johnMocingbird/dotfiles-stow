#!/bin/bash

safari=(
	icon=$SAFARI
	label="GitHub.com || g"
	label.drawing=on
)

github=(
	icon=$SAFARI
	label="GitHub.com || g"
	label.drawing=on
)

sketchybar --add item safari.menu left \
	\
	--add item GitHub popup.safari.menu \
	--set GitHub "${safari[@]}"
