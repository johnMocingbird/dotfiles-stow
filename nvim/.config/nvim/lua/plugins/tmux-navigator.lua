return {
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
	},
	keys = {
		{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
		{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
		{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
		{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
		{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
	},
	init = function()
		-- Terminal mode keybindings for vim-tmux-navigator
		-- These allow navigation to work when focused in a :term buffer
		vim.keymap.set("t", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Navigate Left" })
		vim.keymap.set("t", "<c-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Navigate Down" })
		vim.keymap.set("t", "<c-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Navigate Up" })
		vim.keymap.set("t", "<c-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Navigate Right" })
		vim.keymap.set("t", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Navigate Previous" })
	end,
}
