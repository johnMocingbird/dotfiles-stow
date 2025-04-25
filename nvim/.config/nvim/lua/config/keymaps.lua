-- local Util = require("lazyvim.util")
local map = vim.keymap.set
local mymoc_utils = require("mymoc.utils")

vim.g.mapleader = " "

map({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
map({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
map("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
map("n", "<leader>T", ":term<CR>", { noremap = true, desc = "Terminal Buffer" })

-- map("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
map("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
--
vim.keymap.del("n", "<C-Down>") -- Removes the resize keybinding in normal mode

map("n", "<leader>gd", ":DiffviewOpen origin/master... --imply-local<CR>", { noremap = true, desc = "Git Diff Master" })
map("n", "<leader>C", ":ChatGPT<CR>", { noremap = true, desc = "ChatGpt" })

if vim.loop.os_uname().sysname == "Darwin" then
	map("n", "<leader>oo", ":ObsidianSearch<CR>", { noremap = true, desc = "ObsidianSearch" })
	map("n", "<leader>op", ":ObsidianPasteImg<CR>", { noremap = true, desc = "ObsidianPasteImg" })
	map("n", "<leader>on", ":ObsidianNew", { noremap = true, desc = "ObsidianNew [Title]" })
	map("n", "<leader>ob", ":ObsidianBackLinks", { noremap = true, desc = "ObsidianBackLinks" })
	map("n", "<leader>ol", ":ObsidianLinks<CR>", { noremap = true, desc = "ObsidianLinks" })
	map("n", "<leader>on", ":ObsidianLinkNew<CR>", { noremap = true, desc = "ObsidianLinkNew [Title]" })
	map("n", "<leader>otd", ":ObsidianToday<CR>", { noremap = true, desc = "Today" })
	map("n", "<leader>otm", ":ObsidianTomorrow<CR>", { noremap = true, desc = "ObsidianTomorrow" })
	map("n", "<leader>oy", ":ObsidianYesterday<CR>", { noremap = true, desc = "ObsidianYesterday" })
	map("n", "<leader>ofl", ":ObsidianFollowLink<CR>", { noremap = true, desc = "FollowLink [v|hsplit]" })
	map("n", "<leader>o<CR>", ":ObsidianQuickSwitch<CR>", { noremap = true, desc = "QuickSwitch" })
end

map("n", "<leader>tm", function()
	mymoc_utils.open_rspec_file()
end, { noremap = true, silent = true, desc = "MyMoc: Open RSpec File" })

local harpoon = require("harpoon")

-- heroku logs --tail -a mymoc-staging | sed -E 's/^[^ ]+ [^ ]+ [^ ]+ [^ ]+ (.*)$/\1/'

map(
	"n",
	"<leader>F",
	":lua require('telescope.builtin').lsp_document_symbols({ symbols = { 'Function', 'Method' } })<CR>",
	{ noremap = true, silent = true }
)

-- TODO: -- Function to comment out all 'binding.pry'
function CommentBindingPry()
	local current_buffer = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_set_lines(
		current_buffer,
		0,
		-1,
		false,
		vim.tbl_map(function(line)
			return line:gsub("binding%.pry", "# binding.pry")
		end, vim.api.nvim_buf_get_lines(current_buffer, 0, -1, false))
	)
end

vim.keymap.set("n", "<leader>tc", CommentBindingPry, { desc = "Comment all binding.pry" })

-- if vim.fn.getcwd() == "/home/john/mymoc" then
-- 	map("n", "<leader>sr", function()
-- 		require("telescope.builtin").find_files({ search_dirs = { "/home/john/mymoc/app/models/concerns/tasks/" } })
-- 	end, { desc = "Find Rules" })
-- end

if vim.fn.getcwd() == "/home/john/mymoc" then
	map("n", "<leader>fr", function()
		require("telescope.builtin").find_files({ search_dirs = { "/home/john/mymoc/app/models/concerns/tasks/" } })
	end, { desc = "Find Rules" })
end

map(
	"n",
	"<leader>S",
	"<cmd>source ~/.config/nvim/lua/luasnippets/luasnip.lua<CR>",
	{ noremap = true, desc = "reload luasnippets" }
)

map("n", "<leader>fm", "<cmd>lua require('mymoc.telescope_grep').grep_menu()<CR>", { noremap = true, silent = true })
harpoon.setup()

map("n", "<C-S-P>", function()
	harpoon:list():prev()
end)

map("n", "<C-S-N>", function()
	harpoon:list():next()
end)

map("n", "<leader><CR>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

map("n", "<leader>hm", function()
	harpoon:list():add()
end)

map(
	"n",
	"zi",
	":lua vim.opt.foldmethod = 'indent'<CR>",
	{ noremap = true, desc = "set foldmethod indent", silent = true }
)
map(
	"n",
	"zT",
	":lua vim.opt.foldmethod = 'expr'<CR>",
	{ noremap = true, desc = "foldmethod Treesitter", silent = true }
)

require("ror").setup({})
map("n", "<leader>rc", ":lua require('ror.commands').list_commands()<CR>", { silent = true, desc = "Rails Console" })
-- map(
-- 	"n",
-- 	"<leader>T",
-- 	":lua require('ror.test').run()<CR>",
-- 	{ noremap = true, silent = true, desc = "Rspec: Test File" }
-- )
--
map("n", "<leader>tT", ":TestFile -strategy=neovim<CR>", { desc = "Rspec: Test File", noremap = true, silent = true })

map(
	"n",
	"<leader>tR",
	":TestNearest -strategy=neovim<CR>",
	{ desc = "Rspec: Test Nearest", noremap = true, silent = true }
)

map(
	"n",
	"<leader>ypwf",
	":lua COPY_RELATIVE_PATH_TO_CLIPBOARD()<CR>",
	{ desc = "Copy Relative File Path", noremap = true, silent = true }
)

map(
	"n",
	"<leader>gn",
	":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
	{ noremap = true, silent = true, desc = "Worktrees" }
)

map(
	"n",
	"<leader>gt",
	":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
	{ noremap = true, silent = true, desc = "Worktrees" }
)

-- terminal bindings
map("t", "<C-t>", "<C-\\><C-n>", { noremap = true })
map("t", "<C-h>", "<C-s><b>", { noremap = true })

-------------------------------------------------------------------------------------------------------------
-----------------------------------DEFAULT KEY BINDINGS------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------
-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
-- map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
-- map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
-- map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
-- map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function()
	Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
	"n",
	"<leader>ur",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / clear hlsearch / diff update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- formatting
map({ "n", "v" }, "<leader>cf", function()
	LazyVim.format({ force = true })
end, { desc = "Format" })

-- diagnostic
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- stylua: ignore starts

-- toggle options
LazyVim.format.snacks_toggle():map("<leader>uf")
LazyVim.format.snacks_toggle(true):map("<leader>uF")
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle
	.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
	:map("<leader>uc")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
if vim.lsp.inlay_hint then
	Snacks.toggle.inlay_hints():map("<leader>uh")
end

-- lazygit
if vim.fn.executable("lazygit") == 1 then
	map("n", "<leader>gg", function()
		Snacks.lazygit({ cwd = LazyVim.root.git() })
	end, { desc = "Lazygit (Root Dir)" })
	map("n", "<leader>gG", function()
		Snacks.lazygit()
	end, { desc = "Lazygit (cwd)" })
	map("n", "<leader>gb", function()
		Snacks.git.blame_line()
	end, { desc = "Git Blame Line" })
	map("n", "<leader>gB", function()
		Snacks.gitbrowse()
	end, { desc = "Git Browse" })
	map("n", "<leader>gf", function()
		Snacks.lazygit.log_file()
	end, { desc = "Lazygit Current File History" })
	map("n", "<leader>gl", function()
		Snacks.lazygit.log({ cwd = LazyVim.root.git() })
	end, { desc = "Lazygit Log" })
	map("n", "<leader>gL", function()
		Snacks.lazygit.log()
	end, { desc = "Lazygit Log (cwd)" })
end

-- ui user interface
-- map("<leader>N", function()
-- 	Snacks.notifier.show_history()
-- end, { desc = "Notification History" })
--

map("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
map("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

map("n", "<leader>bt", function()
	local visable = vim.o.showtabline
	if visable ~= 0 then
		vim.cmd("set showtabline=0")
	else
		vim.cmd("set showtabline=2")
	end
end, { desc = "Toggle Buffer Line" })

map("n", "<leader>N", ":NnnPicker<CR>", { noremap = true, desc = "nnn picker" })
map("n", "<leader>e", ":NnnExplorer<CR>", { noremap = true, desc = "nnn Explorer" })
-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- LazyVim Changelog
map("n", "<leader>L", function()
	LazyVim.news.changelog()
end, { desc = "LazyVim Changelog" })

-- floating terminal
map("n", "<leader>fT", function()
	Snacks.terminal()
end, { desc = "Terminal (cwd)" })
map("n", "<leader>ft", function()
	Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })
map("n", "<c-/>", function()
	Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })
map("n", "<c-_>", function()
	Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "which_key_ignore" })

-- Terminal Mappings
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- windows
map("n", "<leader>w", "<c-w>", { desc = "Windows", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
-- LazyVim.ui.maximize():map("<leader>wm")

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

local wk = require("which-key")
wk.register({
	g = {
		name = "+Git",
		p = {
			name = "+Pull Request",
			c = { "<cmd>GHClosePR<cr>", "Close" },
			d = { "<cmd>GHPRDetails<cr>", "Details" },
			e = { "<cmd>GHExpandPR<cr>", "Expand" },
			o = { "<cmd>GHOpenPR<cr>", "Open" },
			p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
			r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
			t = { "<cmd>GHOpenToPR<cr>", "Open To" },
			z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
		},
		h = {
			name = "+Github",
			c = {
				name = "+Commits",
				c = { "<cmd>GHCloseCommit<cr>", "Close" },
				e = { "<cmd>GHExpandCommit<cr>", "Expand" },
				o = { "<cmd>GHOpenToCommit<cr>", "Open To" },
				p = { "<cmd>GHPopOutCommit<cr>", "Pop Out" },
				z = { "<cmd>GHCollapseCommit<cr>", "Collapse" },
			},
			i = {
				name = "+Issues",
				p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
			},
			l = {
				name = "+Litee",
				t = { "<cmd>LTPanel<cr>", "Toggle Panel" },
			},
			r = {
				name = "+Review",
				b = { "<cmd>GHStartReview<cr>", "Begin" },
				c = { "<cmd>GHCloseReview<cr>", "Close" },
				d = { "<cmd>GHDeleteReview<cr>", "Delete" },
				e = { "<cmd>GHExpandReview<cr>", "Expand" },
				s = { "<cmd>GHSubmitReview<cr>", "Submit" },
				z = { "<cmd>GHCollapseReview<cr>", "Collapse" },
			},
			t = {
				name = "+Threads",
				c = { "<cmd>GHCreateThread<cr>", "Create" },
				n = { "<cmd>GHNextThread<cr>", "Next" },
				t = { "<cmd>GHToggleThread<cr>", "Toggle" },
			},
		},
	},
}, { prefix = "<leader>" })

map("n", "<leader>dD", [[:lua CalculateDateDifference()<CR>]], { noremap = true, desc = "Difference" })

function CalculateDateDifference()
	local start_date = vim.fn.input("Start Date:")
	local end_date = vim.fn.input("End Date:")
	local handle = io.popen(
		'ruby -e \'require "date"; d1 = Date.strptime("'
			.. start_date
			.. '", "%d, %m, %Y"); d2 = Date.strptime("'
			.. end_date
			.. '", "%d, %m, %Y"); puts (d2 - d1).to_i\''
	)
	local result = handle:read("*a")
	handle:close()

	print(result)
end
