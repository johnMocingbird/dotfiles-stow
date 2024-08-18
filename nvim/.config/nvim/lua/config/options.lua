local opt = vim.opt
opt.clipboard = "unnamedplus" -- Sync with system clipboard

-- Disable autoformat for lua files
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "rb", "js", "jsx", "ts" },
	callback = function()
		vim.b.autoformat = false
	end,
})
