local colors = require("colors")

-- Add custom event for Rails server updates
sbar.add("event", "rails_update")

-- Rails icon
local rails = sbar.add("item", "rails_server", {
	position = "center",
	display = 1,
	icon = {
		string = "􀪬",
		font = {
			family = "SF Pro",
			size = 16.0,
		},
		color = colors.red,
		padding_left = 8,
		padding_right = 4,
	},
	label = {
		drawing = false,
	},
	background = {
		drawing = false,
	},
	padding_left = 0,
	padding_right = 0,
	drawing = true,
	update_freq = 2,
	updates = true,
})

-- Claude status dot for Rails project
local rails_claude = sbar.add("item", "rails_claude_dot", {
	position = "center",
	display = 1,
	icon = {
		string = "●",
		font = {
			family = "SF Pro",
			size = 12.0,
		},
		color = colors.red,
		padding_left = 4,
		padding_right = 8,
	},
	label = {
		drawing = false,
	},
	background = {
		drawing = false,
	},
	padding_left = 0,
	padding_right = 10,
	drawing = true,
	update_freq = 1,
	updates = true,
})

-- Bracket to group icon + dot with single border
local rails_bracket = sbar.add("bracket", "rails_bracket", {
	rails.name,
	rails_claude.name,
}, {
	background = {
		color = 0xff24283b,
		border_color = 0xff414868,
		border_width = 2,
		corner_radius = 8,
	},
})

-- Spacer AFTER the bracket
sbar.add("item", "rails_spacer_after", {
	position = "center",
	display = 1,
	width = 10,
	background = { drawing = false },
})

-- Track previous status to avoid flickering
local prev_status = "stopped"
local prev_claude_status = "finished"

rails:subscribe("rails_update", function(env)
	local status = env.STATUS or "stopped"
	local claude_status = env.CLAUDE_STATUS or "finished"

	-- Update server icon color based on status
	if status ~= prev_status then
		if status == "stopped" then
			rails:set({ icon = { color = colors.grey } })
		elseif status == "starting" or status == "booting" then
			rails:set({ icon = { color = colors.orange } })
		elseif status == "ready" then
			rails:set({ icon = { color = colors.green } })
		elseif status == "error" then
			rails:set({ icon = { color = colors.red } })
		end
		prev_status = status
	end

	-- Only update Claude dot color if it changed
	if claude_status ~= prev_claude_status then
		local color
		if claude_status == "running" then
			color = colors.green
		elseif claude_status == "waiting" then
			color = colors.yellow
		else
			color = colors.red
		end
		rails_claude:set({ icon = { color = color } })
		prev_claude_status = claude_status
	end
end)

rails:subscribe("routine", function()
	sbar.exec("~/.config/sketchybar/plugins/rails_status.sh")
end)
