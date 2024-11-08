local opt = vim.opt
opt.clipboard = "unnamedplus" -- Sync with system clipboard

vim.api.nvim_set_hl(0, "FlashLabel", { foreground = "#ffffff", background = "#9f83d2" })
vim.g.autoformat = true
-- Disable autoformat for lua files
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "rb", "js", "jsx", "ts" },
	callback = function()
		vim.b.autoformat = false
	end,
})
