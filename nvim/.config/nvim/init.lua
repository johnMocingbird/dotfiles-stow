require("config.lazy")
function COPY_RELATIVE_PATH_TO_CLIPBOARD()
	local cwd = vim.fn.getcwd()
	local fullpath = vim.fn.expand("%:p")
	local relativepath = vim.fn.substitute(fullpath, "^" .. cwd .. "/", "", "")
	vim.fn.setreg("+", relativepath)
end
require("telescope").load_extension("git_worktree")
if vim.loop.os_uname().sysname == "Darwin" then
	require("obsidian")
end
