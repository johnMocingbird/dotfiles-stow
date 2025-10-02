local colors = require("colors")

-- Add custom event for Rails server updates
sbar.add("event", "rails_update")

local rails = sbar.add("item", "rails_server", {
	position = "center",
	display = 1, -- Main bar
	icon = {
		string = "􀪬",
		font = {
			family = "SF Pro",
			size = 16.0,
		},
		color = colors.red,
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

rails:subscribe("rails_update", function(env)
	local status = env.STATUS or "stopped"

	if status == "stopped" then
		rails:set({ drawing = false })
	elseif status == "starting" or status == "booting" then
		rails:set({
			drawing = true,
			icon = { color = colors.orange },
		})
	elseif status == "ready" then
		rails:set({
			drawing = true,
			icon = { color = colors.green },
		})
	elseif status == "error" then
		rails:set({
			drawing = true,
			icon = { color = colors.red },
		})
	end
end)

rails:subscribe("routine", function()
	sbar.exec("~/.config/sketchybar/plugins/rails_status.sh")
end)
