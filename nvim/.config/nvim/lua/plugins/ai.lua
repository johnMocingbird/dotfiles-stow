return {
	{
		"Exafunction/windsurf.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-telescope/telescope.nvim",
		},
		event = "VeryLazy",
		config = function()
			require("codeium").setup({
				enable_cmp_source = true,
				virtual_text = {
					enabled = true,
					filetypes = {
						-- Disable Codeium for specific filetypes
						markdown = true,
						-- ["chatgpt-input"] = false,
					},
					default_filetype_enabled = true,
				},
				-- Include any other settings you have
			})
		end,
	},
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		opts = {
			terminal = {
				split_side = "right",
				split_width_percentage = 0.35,
        provider = "auto", -- "auto", "snacks", "native", "external", "none", or custom provider table
        auto_close = true,
			},
			diff_opts = {
        auto_close_on_accept = true,
        vertical_split = true,
        open_in_current_tab = true,
        keep_terminal_focus = false, -- If t
			},
		},
		keys = {
			{ "<leader>A", nil, desc = "AI/Claude Code" },
			{ "<leader>Ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			{ "<C-a>", "<cmd>ClaudeCode<cr>", mode = { "n", "i" }, desc = "Toggle Claude" },
			{ "<leader>Af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			{ "<C-f>", "<cmd>ClaudeCodeFocus<cr>", mode = { "n", "i" }, desc = "Focus Claude" },
			{ "<leader>Ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			{ "<leader>AC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
			{ "<leader>Am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
			{ "<leader>Ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
			{ "<leader>As", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
			{
				"<leader>As",
				"<cmd>ClaudeCodeTreeAdd<cr>",
				desc = "Add file",
				ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
			},
			-- Diff management
			{ "<leader>Aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
			{ "<leader>Ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		},
	},
}
