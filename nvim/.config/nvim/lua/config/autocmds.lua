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
