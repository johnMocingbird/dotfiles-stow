local sbar = require("sketchybar")

sbar.add("alias", "MeetingBar", {
	position = "center",
	display = 2, -- Only show on second monitor
	alias = {
		scale = 1.25,
	},
})

-- sketchybar --add alias MeetingBar left

-- sbar.add("item", { position = "right", width = settings.group_paddings })
