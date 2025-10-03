local colors = require("colors")
local icons = require("icons")

-- Add custom event for dotfiles updates
sbar.add("event", "dotfiles_update")

-- Dotfiles gear icon
local dotfiles = sbar.add("item", "dotfiles", {
	position = "center",
	display = 1,
	icon = {
		string = icons.gear,
		font = {
			family = "SF Pro",
			size = 16.0,
		},
		color = colors.blue,
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

-- Claude status dot for dotfiles project
local dotfiles_claude = sbar.add("item", "dotfiles_claude_dot", {
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
local dotfiles_bracket = sbar.add("bracket", "dotfiles_bracket", {
	dotfiles.name,
	dotfiles_claude.name,
}, {
	background = {
		color = 0xff24283b,
		border_color = 0xff414868,
		border_width = 2,
		corner_radius = 8,
	},
})

-- Track previous status to avoid flickering
local prev_claude_status = "finished"

dotfiles:subscribe("dotfiles_update", function(env)
	local claude_status = env.CLAUDE_STATUS or "finished"

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
		dotfiles_claude:set({ icon = { color = color } })
		prev_claude_status = claude_status
	end
end)

dotfiles:subscribe("routine", function()
	sbar.exec("~/.config/sketchybar/plugins/dotfiles_status.sh")
end)
