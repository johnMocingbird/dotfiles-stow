local Util = require("lazyvim.util")
local map = vim.keymap.set

vim.g.mapleader = " "
-- map("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
-- map("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
map("n", "<leader>gd", ":DiffviewOpen origin/master... --imply-local<CR>", { noremap = true, desc = "Git Diff Master" })

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

require("ror").setup({
	test = {
		file = "Testing File...",
		line = "Testing current block...",
	},
	coverage = {
		up = "DiffAdd",
		down = "DiffDelete",
	},
	notification = "OKAY!",
	fail_icon = "XXX",
})
map("n", "<leader>rc", ":lua require('ror.commands').list_commands()<CR>", { silent = true, desc = "Rails Console" })
map(
	"n",
	"<leader>T",
	":lua require('ror.test').run()<CR>",
	{ noremap = true, silent = true, desc = "Rspec: Test File" }
)

map("n", "<leader>t", ":TestNearest<CR>", { desc = "Rspec: Test Nearest", noremap = true, silent = true })

map(
	"n",
	"<leader>ypwf",
	":lua COPY_RELATIVE_PATH_TO_CLIPBOARD()<CR>",
	{ desc = "Copy Relative File Path", noremap = true, silent = true }
)

map(
	"n",
	"<leader>gt",
	":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
	{ noremap = true, silent = true, desc = "Worktrees" }
)

map(
	"n",
	"<leader>gn",
	":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
	{ noremap = true, silent = true, desc = "Worktrees" }
)
map(
	"n",
	"<leader>gC",
	":lua CreateGitWorktreeWithInput()<CR>",
	{ noremap = true, silent = true, desc = "Create Git worktree with user inputs" }
)

function CreateGitWorktreeWithInput()
	local branch_name = vim.fn.input("Branch name: ")
	local start_point = vim.fn.input("Start point (e.g., master): ")
	local upstream = vim.fn.input("Upstream (e.g., origin): ")
	require("git-worktree").create_worktree(branch_name, start_point, upstream)
end

map("t", "<C-t>", "<C-\\><C-n>", { noremap = true })

-------------------------------------------------------------------------------------------------------------
-----------------------------------DEFAULT KEY BINDINGS------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------

-- tree sitter
--
-- map("n", "<leader>fe", function()
-- 	require("neo-tree.command").execute({ toggle = true, dir = Util.root() })
-- end, { desc = "Toggle auto format (global)" })
--
-- keys = {
--       {
--         "<leader>fe",
--         function()
--           require("neo-tree.command").execute({ toggle = true, dir = Util.root() })
--         end,
--         desc = "Explorer NeoTree (root dir)",
--       },
--       {
--         "<leader>fE",
--         function()
--           require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
--         end,
--         desc = "Explorer NeoTree (cwd)",
--       },
--       { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
--       { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
--       {
--         "<leader>ge",
--         function()
--           require("neo-tree.command").execute({ source = "git_status", toggle = true })
--         end,
--         desc = "Git explorer",
--       },
--       {
--         "<leader>be",
--         function()
--           require("neo-tree.command").execute({ source = "buffers", toggle = true })
--         end,
--         desc = "Buffer explorer",
--       },
--     }
--

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
	Util.format({ force = true })
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

-- stylua: ignore start

-- toggle options
map("n", "<leader>uf", function() Util.format.toggle() end, { desc = "Toggle auto format (global)" })
map("n", "<leader>uF", function() Util.format.toggle(true) end, { desc = "Toggle auto format (buffer)" })
map("n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>uL", function() Util.toggle("relativenumber") end, { desc = "Toggle Relative Line Numbers" })
map("n", "<leader>ul", function() Util.toggle.number() end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ud", function() Util.toggle.diagnostics() end, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
  map( "n", "<leader>uh", function() Util.toggle.inlay_hints() end, { desc = "Toggle Inlay Hints" })
end
map("n", "<leader>uT", function() if vim.b.ts_highlight then vim.treesitter.stop() else vim.treesitter.start() end end, { desc = "Toggle Treesitter Highlight" })
map("n", "<leader>ub", function() Util.toggle("background", false, {"light", "dark"}) end, { desc = "Toggle Background" })

-- lazygit
map("n", "<leader>gg", function() Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit (root dir)" })
map("n", "<leader>dd", function() Util.terminal({ "dooit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false }) end, { desc = "Dooit" })
map("n", "<leader>gG", function() Util.terminal({ "lazygit" }, {esc_esc = false, ctrl_hjkl = false}) end, { desc = "Lazygit (cwd)" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- LazyVim Changelog
map("n", "<leader>L", function() Util.news.changelog() end, { desc = "LazyVim Changelog" })

-- floating terminal
local lazyterm = function() Util.terminal(nil, { cwd = Util.root() }) end
map("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<leader>fT", function() Util.terminal() end, { desc = "Terminal (cwd)" })
-- map("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
-- map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- telescope
--
--       { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
--       { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
--       { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
--       { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
--       { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
--       { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
--       { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
--       { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
--       { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
--       { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
--       { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
--       { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
--       { "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
--       { "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
--       { "<leader>sw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
--       { "<leader>sW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
--       { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
--       {
--         "<leader>ss",
--         function()
--           require("telescope.builtin").lsp_document_symbols({
--             symbols = require("lazyvim.config").get_kind_filter(),
--           })
--         end,
--         desc = "Goto Symbol",
--       },
--       {
--         "<leader>sS",
--         function()
--           require("telescope.builtin").lsp_dynamic_workspace_symbols({
--             symbols = require("lazyvim.config").get_kind_filter(),
--           })
--         end,
--         desc = "Goto Symbol (Workspace)",
--       },
--     }d)" },
--       { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
--       { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
--       { "<leader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
--       -- git
--       { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
--       { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
--       -- search
--       { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
--       { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
--       { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
--       { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Comm
--       {
--         "<leader>,",
--         "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
--         desc = "Switch Buffer",
--       },
--       { "<leader>/", Util.telescope("live_grep"), desc = "Grep (root dir)" },
--       { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
--       { "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },
--       -- find
--       { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
--       { "<leader>fc", Util.telescope.config_files(), desc = "Find Config File" },
--       { "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
--       { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cw
--
--tree sitter
-- -- keys = {
--       { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
--       { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
--       { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
--       { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
--       { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
--     }
--     L
--     keys = {
--   { "]]", desc = "Next Reference" },
--   { "[[", desc = "Prev Reference" },
-- }
--
-- keys = {
--       {
--         "<leader>bd",
--         function()
--           local bd = require("mini.bufremove").delete
--           if vim.bo.modified then
--             local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
--             if choice == 1 then -- Yes
--               vim.cmd.write()
--               bd(0)
--             elseif choice == 2 then -- No
--               bd(0, true)
--             end
--           else
--             bd(0)
--           end
--         end,
--         desc = "Delete Buffer",
--       },
--       -- stylua: ignore
--       { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
--     }
--
-- keys = {
--       { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
--       { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
--       { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
--       { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
--       { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
--       { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
--     }
--
--
--keys = {
--     { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
--     { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
--     { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
--   }
-- },
--     { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
--     { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
--     { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
--     { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
--     {
--       "<leader>cA",
--       function()
--         vim.lsp.buf.code_action({
--           context = {
--             only = {
--               "source",
--             },
--             diagnostics = {},
--           },
--         })
--       end,
--       desc = "Source Action",
--       has = "codeAction",
--     }
-- {
--     { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
--     { "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition", has = "definition" },
--     { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
--     { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
--     { "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, desc = "Goto Implementation" },
--     { "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Goto T[y]pe Definition" },
--     { "K", vim.lsp.buf.hover, desc = "Hover" },
--     { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" }
