require("config.lazy")
function COPY_RELATIVE_PATH_TO_CLIPBOARD()
	local cwd = vim.fn.getcwd()
	local fullpath = vim.fn.expand("%:p")
	local relativepath = vim.fn.substitute(fullpath, "^" .. cwd .. "/", "", "")
	vim.fn.setreg("+", relativepath)
end
require("telescope").load_extension("git_worktree")
require("mymoc.telescope_grep")
require("nnn").setup()
if vim.loop.os_uname().sysname == "Darwin" then
	require("obsidian")
end

require("livepreview.config").set({
	port = 5500,
	autokill = false,
	browser = "default",
	dynamic_root = false,
	sync_scroll = true,
	picker = nil,
})
