open -a "Kitty"
open -a "Arc"
open -a "ChatGPT"

sleep 2

browser_id=$(yabai -m query --windows | jq '.[] | select(.app=="Arc") | .id')
kitty_id=$(yabai -m query --windows | jq '.[] | select(.app=="Kitty") | .id')
chatgpt_id=$(yabai -m query --windows | jq '.[] | select(.app=="ChatGPT") | .id')

desired_order=("Arc" "kitty" "ChatGPT")

# Query the current windows
windows=$(yabai -m query --windows)

# Extract the first matching window ID for each desired app
arc_id=$(echo "$windows" | jq -r '.[] | select(.app == "Arc") | .id // empty' | head -n 1)
kitty_id=$(echo "$windows" | jq -r '.[] | select(.app == "kitty") | .id // empty' | head -n 1)
chatgpt_id=$(echo "$windows" | jq -r '.[] | select(.app == "ChatGPT") | .id // empty' | head -n 1)

sleep 1
# Reorder windows
if [ -n "$arc_id" ]; then
	yabai -m window "$arc_id" --warp first
fi

if [ -n "$chatgpt_id" ]; then
	yabai -m window "$chatgpt_id" --warp last
fi

sleep 1

if [ -n "$arc_id" ]; then
	yabai -m window "$arc_id" --warp first
fi

if [ -n "$chatgpt_id" ]; then
	yabai -m window "$chatgpt_id" --warp last
fi

yabai -m space --balance

open -a "kitty"
sleep 1

yabai -m window --resize right:700:0
yabai -m window --resize left:-700:0
