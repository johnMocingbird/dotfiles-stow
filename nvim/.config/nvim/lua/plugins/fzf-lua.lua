return {
	"ibhagwan/fzf-lua",
	opts = function()
		local actions = require("fzf-lua.actions")
		return {
			winopts = {
				on_create = function()
					-- Make escape go to normal mode instead of closing
					vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { buffer = true })
				end,
			},
			-- Override default file actions
			files = {
				actions = {
					-- Disable the conflicting keybindings
					["alt-h"] = false,
					["alt-i"] = false,
					-- Add new keybindings that don't conflict
					-- alt-e for exclude/hidden files
					["alt-e"] = { fn = actions.toggle_hidden, reuse = true, header = false },
					-- alt-r for respect/toggle gitignore
					["alt-r"] = { fn = actions.toggle_ignore, reuse = true, header = false },
				},
			},
		}
	end,
}
