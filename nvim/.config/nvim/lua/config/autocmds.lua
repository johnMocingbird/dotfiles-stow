-- Disable autoformat for lua files
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "ruby" },
	callback = function()
		vim.b.autoformat = false
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "query.graphql",
  callback = function()
    require("mymoc.graphql").sync_graphql_to_json()
  end,
})

-- Set filetype to ruby for Rails console temp files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	callback = function()
		local bufname = vim.api.nvim_buf_get_name(0)
		-- Check if we're in a rails_console tmux window and it's a temp file
		local tmux_window = vim.fn.system("tmux display-message -p '#W' 2>/dev/null"):gsub("\n", "")
		local is_rails_console = tmux_window == "rails_console"
		local is_temp_file = bufname:match("/T/") or bufname:match("/tmp/")

		if is_rails_console and is_temp_file and vim.bo.filetype == "" then
			vim.bo.filetype = "ruby"

			-- Disable diagnostics for this temp file to avoid Rubocop errors
			vim.defer_fn(function()
				vim.diagnostic.disable(0)
			end, 100)
		end
	end,
})
