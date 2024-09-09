MODE=$1
COLOR=""
LABEL=$MODE

case $MODE in
"applcation_launcher") LABEL="app" ;;
"window-management-mode") LABEL="window " ;;
"move") LABEL="move" ;;
"resize") LABEL="resize" ;;
"safari") LABEL="safari" ;;
"default") LABEL="default" ;;
"leader") LABEL=" leader" ;;
"system_settings") LABEL="system" ;;
# Add other mode translations here if needed
esac

case $MODE in
"move") COLOR=0xff8aadf4 ;;
"resize") COLOR=0xffa6da95 ;;
"safari") COLOR=0xffa6da95 ;;
"window-management-mode") COLOR=0xffeed49f ;;
"default") COLOR=0xffcad3f5 ;;
"leader") COLOR=0xffcad3f5 ;;
"system_settings") COLOR=0xffcad3f5 ;;
"applcation_launcher") COLOR=0xffcad3f5 ;;
	# add other modes here
esac

sketchybar --set mode_indicator label="$LABEL"
sketchybar --set mode_indicator label.color=$COLOR

# Add your statements at the end
if [[ $MODE == "leader" ]]; then
	sketchybar --set app.menu popup.drawing=on
else
	sketchybar --set app.menu popup.drawing=off
fi
