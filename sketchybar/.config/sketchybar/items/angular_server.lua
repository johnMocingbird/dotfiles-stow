local colors = require("colors")
local icons = require("icons")

-- Add custom event for Angular server updates
sbar.add("event", "angular_update")

local angular = sbar.add("item", "angular_server", {
	position = "center",
	display = 1, -- Main bar
	icon = {
		string = "󰚿",
		font = {
			family = "Hack Nerd Font",
			size = 16.0,
		},
		color = colors.green,
		padding_left = 10,
		padding_right = 10,
	},
	label = {
		drawing = false, -- Hide label, just show icon
	},
	background = {
		drawing = false, -- No background
	},
	padding_left = 5,
	padding_right = 5,
	drawing = false, -- Hidden by default
	update_freq = 2,
	updates = true, -- Always update, even when hidden
})

angular:subscribe("angular_update", function(env)
	local status = env.STATUS or "stopped"

	if status == "stopped" then
		angular:set({ drawing = false })
	elseif status == "starting" or status == "building" then
		angular:set({
			drawing = true,
			icon = { color = colors.orange },
		})
	elseif status == "ready" then
		angular:set({
			drawing = true,
			icon = { color = colors.green },
		})
	elseif status == "error" then
		angular:set({
			drawing = true,
			icon = { color = colors.red },
		})
	end
end)

angular:subscribe("routine", function()
	sbar.exec("~/.config/sketchybar/plugins/angular_status.sh")
end)
