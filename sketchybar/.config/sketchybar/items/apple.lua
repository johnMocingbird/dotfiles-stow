local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

-- Padding item required because of bracket
sbar.add("item", { width = 5 })

local apple = sbar.add("item", "apple", {
	icon = {
		font = { size = 16.0 },
		string = icons.apple,
		padding_right = 8,
		padding_left = 8,
	},
	label = { drawing = false },
	background = {
		color = colors.bg2,
		border_color = colors.black,
		border_width = 1,
	},
	padding_left = 1,
	padding_right = 1,
	click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0",
	popup = { align = "left", drawing = false },
})

local window_mod = sbar.add("item", "window_mod", {
	position = "popup.apple",
	icon = {
		string = "􁺠  W",
		width = 100,
		align = "left",
	},
	label = {
		string = "Window",
		width = 100,
		align = "right",
	},
})

local leader_mode_icons = {
	{
		icon = "p 􀰑  􀍟 ",
		label = "System Preferences",
	},
	{
		icon = "x 􀰑  􀃃 ",
		label = "Disabled Mode",
	},
	{
		icon = "􀆧  􀰑  􀣺 ",
		label = "Return to Defulat Mode",
	},
	{
		icon = "W   􀰑  􁺠 ",
		label = "Window Mode",
	},
	{
		icon = "x 􀰑  􀃃 ",
		label = "System Preferences",
	},
}

local function to_snake_case(str)
	return string.gsub(string.lower(str), "%s+", "_")
end

local window_mode = {
	{
		icon = "w 􀰑  􀙇 ",
		label = "Wifi Networks",
	},
	{
		icon = "i 􀰑  􀊰 ",
		label = "Input Select",
	},
	{
		icon = "􀆧  􀰑  􀣺 ",
		label = "Return to Defulat Mode",
	},
	{
		icon = "o 􀰑  􀟶 ",
		label = "Audio Output",
	},
	{
		icon = "d 􀰑  􀣰 ",
		label = "Toggle Desktop Icons",
	},
	{
		icon = "h 􀰑  􀣍 ",
		label = "Toggle hidden files in Finder",
	},
	{
		icon = "p 􀰑  􀪷  ",
		label = "Connect to airPods",
	},
}

function set_items(items)
	local variables = {}
	for _, binding in ipairs(items) do
		local variable_name = to_snake_case(binding.label)
		variables[variable_name] = sbar.add("item", variable_name, {
			position = "popup.apple",
			icon = {
				string = binding.icon,
				width = 100,
				align = "left",
			},
			label = {
				string = binding.label,
				width = 100,
				align = "right",
			},
		})
	end
end

local preferences_mod = sbar.add("item", {
	position = "popup.apple",
	icon = {
		string = "􀍟  P",
		width = 100,
		align = "left",
	},
	label = {
		string = "System Preferences",
		width = 100,
		align = "right",
	},
})

local disabled_mod = sbar.add("item", {
	position = "popup.apple",
	icon = {
		string = "􀃃  x",
		width = 100,
		align = "left",
	},
	label = {
		string = "Disabled",
		width = 100,
		align = "right",
	},
})

local disabled_mod = sbar.add("item", {
	position = "popup.apple",
	icon = {
		string = "􀆧 ",
		width = 100,
		align = "left",
	},
	label = {
		string = "Return to default mode",
		width = 100,
		align = "right",
	},
})

-- Double border for apple using a single item bracket
sbar.add("bracket", { apple.name }, {
	background = {
		color = 0xFF1A1B26,
		height = 30,
		border_color = colors.grey,
	},
})

-- Padding item required because of bracket
sbar.add("item", { width = 7 })

apple:subscribe("skhd_mode", function(env)
	print(env)
	if env == "leader_mode" then
		apple:set({
			popup = { align = "left", drawing = true },
		})
		set_items(leader_mode_icons)
	end
end)

-- I don't understand what I need to do for custom event...
-- it looks like I need to do 2 things..
-- 1. create the custom event- i guess this is where I need to define the script too..
-- 2. trigger the script. (this is where i can pass the skhd_mode via env varibles)
--
