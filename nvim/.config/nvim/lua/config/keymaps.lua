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

-- Reload entire Neovim config
map("n", "<leader>R", "<cmd>luafile ~/.config/nvim/init.lua<CR>", { noremap = true, desc = "Reload Neovim config" })

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

-- map("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
-- map("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
Snacks.scroll.disable()

map("n", "<leader>bt", function()
	local visable = vim.o.showtabline
	if visable ~= 0 then
		vim.cmd("set showtabline=0")
	else
		vim.cmd("set showtabline=2")
	end
end, { desc = "Toggle Buffer Line" })

map("n", "<leader>nn", ":NnnPicker<CR>", { noremap = true, desc = "nnn picker" })
map("n", "<leader>E", ":NnnExplorer<CR>", { noremap = true, desc = "nnn Explorer" })

-- AI Terminal Focus/Start function with toggle
function FocusOrStartAI()
	local ai_buf = FindAITerminal()

	if ai_buf then
		-- Check if AI terminal is currently visible in a window
		local win = vim.fn.bufwinid(ai_buf)
		if win ~= -1 then
			-- Terminal is visible, close it (toggle off)
			vim.api.nvim_win_close(win, false)
			return
		else
			-- Terminal exists but not visible, show it in popup
			Snacks.terminal(nil, { buf = ai_buf })
			return
		end
	end

	-- No AI terminal found, prompt user to start one
	vim.ui.select({ "claude", "gemini" }, { prompt = "No AI terminal found. Start:" }, function(choice)
		if choice then
			StartAITerminal(choice)
		end
	end)
end

-- Function to start AI terminal with custom naming and icon
function StartAITerminal(ai_name)
	-- Icons for different AIs
	local icons = {
		claude = "🤖",
		gemini = "✨",
	}
	local icon = icons[ai_name] or "🤖"
	local display_name = icon .. " " .. ai_name:gsub("^%l", string.upper)

	-- Use Snacks terminal with custom options to try to set title
	local opts = {
		cwd = LazyVim.root(),
		-- Try to set terminal title (this might work depending on terminal)
		env = {
			TERM_TITLE = display_name,
		},
	}

	local term = Snacks.terminal(ai_name, opts)

	-- Alternative approach: use autocmd to rename buffer after creation
	vim.defer_fn(function()
		local buf = vim.api.nvim_get_current_buf()
		if vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
			-- Set buffer variable for identification first
			vim.api.nvim_buf_set_var(buf, "ai_terminal", ai_name)
			vim.api.nvim_buf_set_var(buf, "ai_display_name", display_name)

			-- Try multiple approaches to set buffer name
			local success = false

			-- Method 1: Direct buffer rename
			local current_name = vim.api.nvim_buf_get_name(buf)
			if current_name and current_name ~= "" then
				local new_name = vim.fn.fnamemodify(current_name, ":h") .. "/" .. display_name
				pcall(function()
					vim.api.nvim_buf_set_name(buf, new_name)
					success = true
				end)
			end

			-- Method 2: If that fails, try setting just the filename part
			if not success then
				pcall(function()
					vim.api.nvim_buf_set_name(buf, display_name)
					success = true
				end)
			end

			-- Method 3: Use buffer-local title variable (for plugins that support it)
			vim.api.nvim_buf_set_var(buf, "term_title", display_name)

			-- Try to send escape sequence to set terminal title
			pcall(function()
				local job_id = vim.api.nvim_buf_get_var(buf, "terminal_job_id")
				if job_id then
					local escape_seq = string.format("\027]0;%s\007", display_name)
					vim.api.nvim_chan_send(job_id, escape_seq)
				end
			end)
		end
	end, 200)
end

-- Enhanced AI detection that also checks buffer variables
function FindAITerminal()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) then
			local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
			if buftype == "terminal" then
				-- Check if this is marked as an AI terminal
				local ok, ai_name = pcall(vim.api.nvim_buf_get_var, buf, "ai_terminal")
				if ok and ai_name then
					return buf
				end

				-- Fallback: check terminal content
				local lines = vim.api.nvim_buf_get_lines(buf, -50, -1, false)
				for _, line in ipairs(lines) do
					if string.find(line, "claude") or string.find(line, "gemini") then
						return buf
					end
				end
			end
		end
	end
	return nil
end

map("n", "<leader>ai", ":lua FocusOrStartAI()<CR>", { noremap = true, desc = "Focus/Start AI Terminal" })

-- Function to get tmux sessions
function GetTmuxSessions()
	local handle = io.popen("tmux list-sessions -F '#{session_name}' 2>/dev/null")
	if not handle then
		return {}
	end

	local sessions = {}
	for line in handle:lines() do
		table.insert(sessions, line)
	end
	handle:close()
	return sessions
end

-- Function to send text to tmux ai_cli window
function SendToTmuxAI()
	local selected_text = ""

	-- Check if we're being called from visual mode
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")

	-- If visual marks exist and are different, we have a selection
	if start_pos[2] ~= 0 and end_pos[2] ~= 0 and (start_pos[2] ~= end_pos[2] or start_pos[3] ~= end_pos[3]) then
		-- Get visually selected text
		local lines = vim.fn.getline(start_pos[2], end_pos[2])
		if #lines == 1 then
			-- Single line selection
			selected_text = string.sub(lines[1], start_pos[3], end_pos[3])
		else
			-- Multi-line selection
			lines[1] = string.sub(lines[1], start_pos[3])
			lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
			selected_text = table.concat(lines, "\n")
		end
	else
		-- No selection, get current line
		selected_text = vim.api.nvim_get_current_line()
	end

	if selected_text == "" then
		vim.notify("No text selected", vim.log.levels.WARN)
		return
	end

	-- Get tmux sessions
	local sessions = GetTmuxSessions()
	if #sessions == 0 then
		vim.notify("No tmux sessions found", vim.log.levels.ERROR)
		return
	end

	-- Let user select session
	vim.ui.select(sessions, { prompt = "Select tmux session:" }, function(session)
		if session then
			SendTextToSession(session, selected_text)
		end
	end)
end

-- Function to send text to specific tmux session ai_cli window
function SendTextToSession(session, text)
	-- Check if ai_cli window exists in session
	local check_cmd =
		string.format("tmux list-windows -t %s -F '#{window_name}' 2>/dev/null | grep -q '^ai_cli$'", session)
	local check_result = os.execute(check_cmd)

	if check_result ~= 0 then
		vim.notify(string.format("No 'ai_cli' window found in session '%s'", session), vim.log.levels.ERROR)
		return
	end

	-- Escape special characters for tmux
	text = text:gsub("'", "'\"'\"'")
	text = text:gsub("\n", " ")

	-- Send text to ai_cli window
	local send_cmd = string.format("tmux send-keys -t %s:ai_cli '%s' Enter", session, text)
	local result = os.execute(send_cmd)

	if result == 0 then
		vim.notify(string.format("Text sent to %s:ai_cli", session), vim.log.levels.INFO)
	else
		vim.notify("Failed to send text to tmux", vim.log.levels.ERROR)
	end
end

-- Function to send text to current session's ai_cli window
function SendToCurrentSessionAI()
	local selected_text = ""

	-- Check if we're being called from visual mode (same logic as SendToTmuxAI)
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")

	if start_pos[2] ~= 0 and end_pos[2] ~= 0 and (start_pos[2] ~= end_pos[2] or start_pos[3] ~= end_pos[3]) then
		-- Get visually selected text
		local lines = vim.fn.getline(start_pos[2], end_pos[2])
		if #lines == 1 then
			-- Single line selection
			selected_text = string.sub(lines[1], start_pos[3], end_pos[3])
		else
			-- Multi-line selection
			lines[1] = string.sub(lines[1], start_pos[3])
			lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
			selected_text = table.concat(lines, "\n")
		end
	else
		-- No selection, get current line
		selected_text = vim.api.nvim_get_current_line()
	end

	if selected_text == "" then
		vim.notify("No text selected", vim.log.levels.WARN)
		return
	end

	-- Get current tmux session
	local current_session = vim.fn.system("tmux display-message -p '#S' 2>/dev/null"):gsub("\n", "")
	if current_session == "" then
		vim.notify("Not in a tmux session", vim.log.levels.ERROR)
		return
	end

	-- Send directly to current session
	SendTextToSession(current_session, selected_text)
end


map(
	"v",
	"<leader>as",
	":lua SendToCurrentSessionAI()<CR>",
	{ noremap = true, desc = "Send selection to current session AI" }
)
map(
	"n",
	"<leader>as",
	":lua SendToCurrentSessionAI()<CR>",
	{ noremap = true, desc = "Send line to current session AI" }
)
map(
	"v",
	"<leader>aS",
	":lua SendToTmuxAI()<CR>",
	{ noremap = true, desc = "Send selection to tmux AI (choose session)" }
)
map("n", "<leader>aS", ":lua SendToTmuxAI()<CR>", { noremap = true, desc = "Send line to tmux AI (choose session)" })

-- Function to poll for AI response completion
function PollForAIResponse(session, prompt_template, attempt, max_attempts)
	if attempt > max_attempts then
		vim.notify("AI response timeout - check ai_cli window manually", vim.log.levels.WARN)
		return
	end

	-- Check if AI is still generating or done
	-- Look at the last 10 lines to detect completion
	local check_cmd = string.format("tmux capture-pane -t %s:ai_cli -p | tail -10", session)
	local handle = io.popen(check_cmd)
	if not handle then
		return
	end

	local output = handle:read("*a")
	handle:close()

	-- Look for signs that AI is done:
	-- 1. Cursor is back at a prompt (shell prompt with path)
	-- 2. "What would you like" or similar prompt from AI CLI
	-- 3. No streaming indicators (no "..." or typing indicators)
	-- 4. Presence of shell prompt characters or completion markers
	local is_done = false

	-- Check for shell prompt return (path in prompt)
	if output:match("~/") or output:match("⎿") or output:match("▕") then
		is_done = true
	end

	-- Check for AI CLI completion messages
	if output:match("What would you like") or output:match("How can I help") or output:match("^>%s*$") then
		is_done = true
	end

	-- Check if still streaming (presence of streaming indicators)
	if output:match("%.%.%.") or output:match("typing") or output:match("generating") then
		is_done = false
	end

	if is_done then
		-- AI is done, send notification
		vim.defer_fn(function()
			CheckAIResponse(session, prompt_template)
		end, 1000)
	else
		-- Still generating, check again in 3 seconds
		vim.defer_fn(function()
			PollForAIResponse(session, prompt_template, attempt + 1, max_attempts)
		end, 3000)
	end
end

-- Function to check AI response and send to ntfy.sh
function CheckAIResponse(session, prompt_template)
	-- Capture the last 200 lines from ai_cli window
	local capture_cmd = string.format("tmux capture-pane -t %s:ai_cli -p -S -200", session)
	local handle = io.popen(capture_cmd)
	if not handle then
		return
	end

	local output = handle:read("*a")
	handle:close()

	-- Get all lines
	local lines = {}
	for line in output:gmatch("[^\r\n]+") do
		table.insert(lines, line)
	end

	-- Find the last occurrence of the user's prompt to know where AI response starts
	local prompt_end_idx = 0
	for i = #lines, 1, -1 do
		if lines[i]:match("^Please debug") or lines[i]:match("^Please explain")
			or lines[i]:match("^Please document") or lines[i]:match("^Please refactor")
			or lines[i]:match("^Please optimize") or lines[i]:match("^Please write") then
			prompt_end_idx = i
			break
		end
	end

	-- Find AI response text after the prompt, skip code blocks and status lines
	local response_lines = {}
	local in_code_block = false
	local found_response_start = false

	for i = prompt_end_idx + 1, #lines do
		local line = lines[i]

		-- Detect code block markers (```, ~~~, or indented code)
		if line:match("^```") or line:match("^~~~") then
			in_code_block = not in_code_block
		end

		-- Skip if in code block, empty, or status line
		if not in_code_block
			and line:match("%S")
			and not line:match("TERMINAL")
			and not line:match("term:")
			and not line:match("NORMAL")
			and not line:match("INSERT")
			and not line:match("Bot %d+:")
			and not line:match("^%d+:%d+")
			and not line:match("^>")  -- Skip prompt characters
			and not line:match("^%s*~/")  -- Skip lines starting with home paths
			and not line:match("^%s*/")  -- Skip lines starting with absolute paths
			and not line:match("^%a:")  -- Skip Windows paths (C:, D:, etc.)
			and not line:match("  main ")  -- Skip git branch indicators
			and not line:match("  master ")
			and not line:match("  develop ")
			and not line:match("!%d+")  -- Skip shell prompts with git status (!4, !2, etc.)
			and not line:match("▕▎")  -- Skip prompts with special box characters
			and not line:match("⎿")  -- Skip box drawing characters
			and not line:match("📁")  -- Skip prompts with folder emoji
			and not line:match("📂")  -- Skip prompts with folder emoji
			and not line:match(":heavy_check_mark:")  -- Skip emoji names
			and not line:match(":black_circle_for_record:")  -- Skip emoji names
			and not line:match("Zesting")  -- Skip Claude Code status messages
			and not line:match("esc to interrupt")  -- Skip instruction text
			and not line:match("ctrl%+t")  -- Skip keyboard shortcuts
			and not line:match("Next:")  -- Skip todo reminders
			and not line:match("^%s%s%s%s") then -- Skip heavily indented lines (likely code)

			table.insert(response_lines, line)
			found_response_start = true

			-- Stop after collecting enough text
			if #response_lines >= 15 then
				break
			end
		end
	end

	if #response_lines > 0 then
		-- Join lines into single paragraph with smart spacing
		local message = table.concat(response_lines, " ")

		-- Clean up excessive spaces
		message = message:gsub(" +", " ")
		message = message:gsub("^ +", ""):gsub(" +$", "") -- Trim

		-- Truncate to fit ntfy.sh inline display (keep it short to avoid attachments)
		if #message > 400 then
			message = message:sub(1, 397) .. "..."
		end

		-- Send to ntfy.sh with title, priority, and tags
		local title = string.format("AI: %s", prompt_template)

		-- Determine emoji/tag based on prompt type
		local tag = "robot"
		if prompt_template:match("debug") or prompt_template:match("error") then
			tag = "bug"
		elseif prompt_template:match("explain") then
			tag = "bulb"
		elseif prompt_template:match("optimize") then
			tag = "zap"
		end

		-- Use markdown formatting for better readability
		local formatted_message = message

		-- Escape for shell
		local escaped_title = title:gsub('"', '\\"'):gsub("'", "'\\''")
		local escaped_message = formatted_message:gsub('"', '\\"'):gsub("'", "'\\''")

		local ntfy_cmd = string.format(
			"curl -s -d '%s' -H 'Title: %s' -H 'Priority: 4' -H 'Tags: %s' ntfy.sh/claude_ai > /dev/null 2>&1 &",
			escaped_message,
			escaped_title,
			tag
		)
		os.execute(ntfy_cmd)

		vim.notify("AI response sent to ntfy.sh", vim.log.levels.INFO)
	end
end

-- Function to send code with a preset prompt to current session AI
function SendWithPromptToAI(prompt_template, target_session)
	local selected_text = ""

	-- Check if we're being called from visual mode
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")

	if start_pos[2] ~= 0 and end_pos[2] ~= 0 and (start_pos[2] ~= end_pos[2] or start_pos[3] ~= end_pos[3]) then
		-- Get visually selected text
		local lines = vim.fn.getline(start_pos[2], end_pos[2])
		if #lines == 1 then
			selected_text = string.sub(lines[1], start_pos[3], end_pos[3])
		else
			lines[1] = string.sub(lines[1], start_pos[3])
			lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
			selected_text = table.concat(lines, "\n")
		end
	else
		-- No selection, get current line
		selected_text = vim.api.nvim_get_current_line()
	end

	if selected_text == "" then
		vim.notify("No text selected", vim.log.levels.WARN)
		return
	end

	-- Get tmux session (use target_session if provided, otherwise current session)
	local current_session
	if target_session then
		current_session = target_session
	else
		current_session = vim.fn.system("tmux display-message -p '#S' 2>/dev/null"):gsub("\n", "")
		if current_session == "" then
			vim.notify("Not in a tmux session", vim.log.levels.ERROR)
			return
		end
	end

	-- Check if ai_cli window exists
	local check_ai_cmd = string.format("tmux list-windows -t %s -F '#{window_name}' 2>/dev/null | grep -q '^ai_cli$'", current_session)
	local has_ai_cli = os.execute(check_ai_cmd) == 0

	if not has_ai_cli then
		vim.notify("❌ No ai_cli window found. Use <leader>aw to create one first.", vim.log.levels.ERROR)
		return
	end

	-- Check if Claude is actually running in ai_cli window
	local check_claude_cmd = string.format("tmux capture-pane -t %s:ai_cli -p | tail -20", current_session)
	local handle = io.popen(check_claude_cmd)
	if not handle then
		vim.notify("❌ Failed to check ai_cli window", vim.log.levels.ERROR)
		return
	end

	local ai_output = handle:read("*a")
	handle:close()

	-- Look for signs that Claude/Gemini is running (shell prompt means it's not)
	local claude_running = not ai_output:match("^%s*$") -- Not empty
		and not (ai_output:match("~/") and ai_output:match("zsh")) -- Not just shell prompt

	if not claude_running then
		vim.notify("❌ Claude/Gemini not running in ai_cli window. Start Claude first with 'claude' or 'gemini'", vim.log.levels.ERROR)
		return
	end

	-- Combine prompt template with selected text
	local full_prompt
	if prompt_template == "" then
		full_prompt = selected_text
	else
		full_prompt = prompt_template .. ":\n\n" .. selected_text
	end

	-- Write to a temporary file to handle complex text with newlines
	local tmpfile = os.tmpname()
	local f = io.open(tmpfile, "w")
	if f then
		f:write(full_prompt)
		f:close()

		-- Use tmux load-buffer to load the content, then paste it
		local load_cmd = string.format("tmux load-buffer %s", tmpfile)
		os.execute(load_cmd)

		local paste_cmd = string.format("tmux paste-buffer -t %s:ai_cli", current_session)
		os.execute(paste_cmd)

		-- Small delay to ensure paste completes before sending Enter
		vim.defer_fn(function()
			local enter_cmd = string.format("tmux send-keys -t %s:ai_cli Enter", current_session)
			os.execute(enter_cmd)

			-- Ring bell in ai_cli terminal
			local bell_cmd = string.format("tmux send-keys -t %s:ai_cli 'C-g'", current_session)
			os.execute(bell_cmd)
		end, 100)

		-- Clean up temp file
		os.remove(tmpfile)

		vim.notify(string.format("Sent to AI: %s", prompt_template), vim.log.levels.INFO)

		-- Note: Claude Code Stop hook will automatically send ntfy notification when done
	else
		vim.notify("Failed to create temp file", vim.log.levels.ERROR)
	end
end

-- Function to send code with a custom prompt (asks user for input)
function SendWithCustomPrompt()
	local selected_text = ""

	-- Check if we're being called from visual mode
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")

	if start_pos[2] ~= 0 and end_pos[2] ~= 0 and (start_pos[2] ~= end_pos[2] or start_pos[3] ~= end_pos[3]) then
		-- Get visually selected text
		local lines = vim.fn.getline(start_pos[2], end_pos[2])
		if #lines == 1 then
			selected_text = string.sub(lines[1], start_pos[3], end_pos[3])
		else
			lines[1] = string.sub(lines[1], start_pos[3])
			lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
			selected_text = table.concat(lines, "\n")
		end
	else
		-- No selection, get current line
		selected_text = vim.api.nvim_get_current_line()
	end

	if selected_text == "" then
		vim.notify("No text selected", vim.log.levels.WARN)
		return
	end

	-- Store selected text in a temporary global to pass to the callback
	_G.temp_selected_text = selected_text

	-- Ask user for custom prompt
	vim.ui.input({ prompt = "Enter your prompt: " }, function(custom_prompt)
		local text = _G.temp_selected_text
		_G.temp_selected_text = nil -- Clean up

		if not custom_prompt or custom_prompt == "" then
			vim.notify("No prompt entered", vim.log.levels.WARN)
			return
		end

		-- Get current tmux session
		local current_session = vim.fn.system("tmux display-message -p '#S' 2>/dev/null"):gsub("\n", "")
		if current_session == "" then
			vim.notify("Not in a tmux session", vim.log.levels.ERROR)
			return
		end

		-- Check if ai_cli window exists
		local check_ai_cmd = string.format("tmux list-windows -t %s -F '#{window_name}' 2>/dev/null | grep -q '^ai_cli$'", current_session)
		local has_ai_cli = os.execute(check_ai_cmd) == 0

		if not has_ai_cli then
			vim.notify("❌ No ai_cli window found. Use <leader>aw to create one first.", vim.log.levels.ERROR)
			return
		end

		-- Check if Claude is running (same logic as SendWithPromptToAI)
		local check_claude_cmd = string.format("tmux capture-pane -t %s:ai_cli -p | tail -20", current_session)
		local handle = io.popen(check_claude_cmd)
		if handle then
			local ai_output = handle:read("*a")
			handle:close()

			local claude_running = not ai_output:match("^%s*$")
				and not (ai_output:match("~/") and ai_output:match("zsh"))

			if not claude_running then
				vim.notify("❌ Claude/Gemini not running in ai_cli window. Start Claude first with 'claude' or 'gemini'", vim.log.levels.ERROR)
				return
			end
		end

		-- Combine custom prompt with selected text
		local full_prompt = custom_prompt .. ":\n\n" .. text

		-- Write to temp file and send
		local tmpfile = os.tmpname()
		local f = io.open(tmpfile, "w")
		if f then
			f:write(full_prompt)
			f:close()

			local load_cmd = string.format("tmux load-buffer %s", tmpfile)
			os.execute(load_cmd)

			local paste_cmd = string.format("tmux paste-buffer -t %s:ai_cli", current_session)
			os.execute(paste_cmd)

			-- Small delay to ensure paste completes before sending Enter
			vim.defer_fn(function()
				local enter_cmd = string.format("tmux send-keys -t %s:ai_cli Enter", current_session)
				os.execute(enter_cmd)
			end, 100)

			os.remove(tmpfile)

			vim.notify(string.format("Sent to AI: %s", custom_prompt), vim.log.levels.INFO)
		else
			vim.notify("Failed to create temp file", vim.log.levels.ERROR)
		end
	end)
end

-- Keybinding to send text directly without prompt prefix and execute
map("v", "<leader>a<Space>", ":lua SendWithPromptToAI('')<CR>", { noremap = true, desc = "AI: Send and execute" })
map("n", "<leader>a<Space>", ":lua SendWithPromptToAI('')<CR>", { noremap = true, desc = "AI: Send and execute" })

-- Keybinding to send text to dotfiles session ai_cli
map("v", "<leader>a<CR>", ":lua SendWithPromptToAI('', 'dotfiles')<CR>", { noremap = true, desc = "AI: Send to dotfiles session" })
map("n", "<leader>a<CR>", ":lua SendWithPromptToAI('', 'dotfiles')<CR>", { noremap = true, desc = "AI: Send to dotfiles session" })

-- Keybinding for "Debug this error"
map("v", "<leader>ae", ":lua SendWithPromptToAI('Please debug this error')<CR>", { noremap = true, desc = "AI: Debug this error" })
map("n", "<leader>ae", ":lua SendWithPromptToAI('Please debug this error')<CR>", { noremap = true, desc = "AI: Debug this error" })

-- Keybinding for "Explain this code"
map("v", "<leader>ax", ":lua SendWithPromptToAI('Please explain this code step by step')<CR>", { noremap = true, desc = "AI: Explain code" })
map("n", "<leader>ax", ":lua SendWithPromptToAI('Please explain this code step by step')<CR>", { noremap = true, desc = "AI: Explain code" })

-- Keybinding for "Document this"
map("v", "<leader>ad", ":lua SendWithPromptToAI('Please document this code with comments')<CR>", { noremap = true, desc = "AI: Document code" })
map("n", "<leader>ad", ":lua SendWithPromptToAI('Please document this code with comments')<CR>", { noremap = true, desc = "AI: Document code" })

-- Keybinding for "Refactor this"
map("v", "<leader>ar", ":lua SendWithPromptToAI('Please refactor this code to make it cleaner and more idiomatic')<CR>", { noremap = true, desc = "AI: Refactor code" })
map("n", "<leader>ar", ":lua SendWithPromptToAI('Please refactor this code to make it cleaner and more idiomatic')<CR>", { noremap = true, desc = "AI: Refactor code" })

-- Keybinding for "Optimize this"
map("v", "<leader>ao", ":lua SendWithPromptToAI('Please optimize this code for performance')<CR>", { noremap = true, desc = "AI: Optimize code" })
map("n", "<leader>ao", ":lua SendWithPromptToAI('Please optimize this code for performance')<CR>", { noremap = true, desc = "AI: Optimize code" })

-- Keybinding for "Write tests"
map("v", "<leader>at", ":lua SendWithPromptToAI('Please write tests for this code')<CR>", { noremap = true, desc = "AI: Write tests" })
map("n", "<leader>at", ":lua SendWithPromptToAI('Please write tests for this code')<CR>", { noremap = true, desc = "AI: Write tests" })

-- Keybinding for custom prompt
map("v", "<leader>ap", ":lua SendWithCustomPrompt()<CR>", { noremap = true, desc = "AI: Custom prompt" })
map("n", "<leader>ap", ":lua SendWithCustomPrompt()<CR>", { noremap = true, desc = "AI: Custom prompt" })

-- Manual command to rename current terminal buffer to AI name
function RenameCurrentTerminalToAI()
	local buf = vim.api.nvim_get_current_buf()
	if vim.api.nvim_buf_get_option(buf, "buftype") ~= "terminal" then
		vim.notify("Current buffer is not a terminal", vim.log.levels.WARN)
		return
	end

	vim.ui.select({ "claude", "gemini" }, { prompt = "Which AI is running in this terminal?" }, function(choice)
		if choice then
			local icons = { claude = "🤖", gemini = "✨" }
			local icon = icons[choice] or "🤖"
			local display_name = icon .. " " .. choice:gsub("^%l", string.upper)

			-- Set buffer variables
			vim.api.nvim_buf_set_var(buf, "ai_terminal", choice)
			vim.api.nvim_buf_set_var(buf, "ai_display_name", display_name)

			-- Try to rename buffer
			pcall(function()
				vim.api.nvim_buf_set_name(buf, display_name)
			end)

			vim.notify(string.format("Terminal marked as %s", display_name), vim.log.levels.INFO)
		end
	end)
end

map("n", "<leader>ar", ":lua RenameCurrentTerminalToAI()<CR>", { noremap = true, desc = "Mark terminal as AI" })

-- Function to switch to ai_cli window in current tmux session
function SwitchToAIWindow()
	local current_session = vim.fn.system("tmux display-message -p '#S' 2>/dev/null"):gsub("\n", "")
	if current_session == "" then
		vim.notify("Not in a tmux session", vim.log.levels.ERROR)
		return
	end

	-- Check if ai_cli window exists
	local check_cmd = string.format("tmux list-windows -t %s -F '#{window_name}' 2>/dev/null | grep -q '^ai_cli$'", current_session)
	local has_ai_cli = os.execute(check_cmd) == 0

	if not has_ai_cli then
		-- Create ai_cli window in background (don't switch yet)
		local create_cmd = string.format("tmux new-window -d -t %s -n ai_cli", current_session)
		os.execute(create_cmd)
		vim.notify("Created ai_cli window", vim.log.levels.INFO)
	end

	-- Check if there's already something running (check for actual process, not just text)
	local check_pane_cmd = string.format("tmux list-panes -t %s:ai_cli -F '#{pane_current_command}'", current_session)
	local current_cmd = vim.fn.system(check_pane_cmd):gsub("\n", "")

	-- If it's just zsh/bash (shell), nothing is running
	local has_process = current_cmd ~= "zsh" and current_cmd ~= "bash" and current_cmd ~= ""

	if has_process then
		-- Something is already running, just switch to it
		local switch_cmd = string.format("tmux select-window -t %s:ai_cli", current_session)
		os.execute(switch_cmd)
		vim.notify("Switched to ai_cli window", vim.log.levels.INFO)
	else
		-- Nothing running, show popup in current window first
		vim.ui.select({ "claude", "gemini" }, {
			prompt = "Which AI to run in ai_cli:"
		}, function(choice)
			if not choice then
				return
			end

			-- Switch to ai_cli window
			local switch_cmd = string.format("tmux select-window -t %s:ai_cli", current_session)
			os.execute(switch_cmd)

			-- Send nvim command to ai_cli window
			local nvim_cmd = string.format("tmux send-keys -t %s:ai_cli 'nvim .' Enter", current_session)
			os.execute(nvim_cmd)

			-- Wait for Neovim to start, then send terminal command
			vim.defer_fn(function()
				local term_cmd = string.format("tmux send-keys -t %s:ai_cli ':term %s' Enter", current_session, choice)
				os.execute(term_cmd)
				vim.notify(string.format("Started Neovim with %s terminal in ai_cli window", choice), vim.log.levels.INFO)
			end, 2000)
		end)
	end
end

map("n", "<leader>aw", ":lua SwitchToAIWindow()<CR>", { noremap = true, desc = "Switch to ai_cli window" })

-- Tmux window switching with leader w prefix
map("n", "<leader>we", function()
	vim.fn.system("tmux select-window -t nvim 2>/dev/null || tmux select-window -t neovim")
	vim.notify("Switched to neovim window", vim.log.levels.INFO)
end, { desc = "Switch to neovim window", noremap = true })

map("n", "<leader>wg", function()
	vim.fn.system("tmux select-window -t lazy_git")
	vim.notify("Switched to lazy_git window", vim.log.levels.INFO)
end, { desc = "Switch to lazy_git window", noremap = true })

map("n", "<leader>wa", function()
	vim.fn.system("tmux select-window -t ai_cli")
	vim.notify("Switched to ai_cli window", vim.log.levels.INFO)
end, { desc = "Switch to ai_cli window", noremap = true })

map("n", "<leader>wc", function()
	vim.fn.system("tmux select-window -t rails_console")
	vim.notify("Switched to rails_console window", vim.log.levels.INFO)
end, { desc = "Switch to rails_console window", noremap = true })

map("n", "<leader>ws", function()
	vim.fn.system("tmux select-window -t server")
	vim.notify("Switched to server window", vim.log.levels.INFO)
end, { desc = "Switch to server window", noremap = true })

-- Also add tmux window switching to Ctrl+w prefix (LazyVim window operations)
map("n", "<C-w>e", function()
	vim.fn.system("tmux select-window -t nvim 2>/dev/null || tmux select-window -t neovim")
	vim.notify("Switched to neovim window", vim.log.levels.INFO)
end, { desc = "Switch to neovim window", noremap = true })

map("n", "<C-w>g", function()
	vim.fn.system("tmux select-window -t lazy_git")
	vim.notify("Switched to lazy_git window", vim.log.levels.INFO)
end, { desc = "Switch to lazy_git window", noremap = true })

map("n", "<C-w>a", function()
	vim.fn.system("tmux select-window -t ai_cli")
	vim.notify("Switched to ai_cli window", vim.log.levels.INFO)
end, { desc = "Switch to ai_cli window", noremap = true })

map("n", "<C-w>c", function()
	vim.fn.system("tmux select-window -t rails_console")
	vim.notify("Switched to rails_console window", vim.log.levels.INFO)
end, { desc = "Switch to rails_console window", noremap = true })

map("n", "<C-w>s", function()
	vim.fn.system("tmux select-window -t server")
	vim.notify("Switched to server window", vim.log.levels.INFO)
end, { desc = "Switch to server window", noremap = true })

-- Function to manage Rails server in the server window's Neovim
function ManageRailsServer()
	local current_session = vim.fn.system("tmux display-message -p '#S' 2>/dev/null"):gsub("\n", "")
	if current_session == "" then
		vim.notify("Not in a tmux session", vim.log.levels.ERROR)
		return
	end

	-- Check if server window exists in tmux, create if not
	local check_server_cmd = string.format("tmux list-windows -t %s -F '#{window_name}' 2>/dev/null | grep -q '^server$'", current_session)
	local has_server = os.execute(check_server_cmd) == 0

	if not has_server then
		-- Create server window in tmux
		local create_cmd = string.format("tmux new-window -t %s -n server", current_session)
		os.execute(create_cmd)
		vim.notify("Created server window", vim.log.levels.INFO)
	end

	-- Don't switch to server window, just manage it in background

	-- Check if rails server is already running in server window
	local check_rails_cmd = string.format("tmux capture-pane -t %s:server -p | grep -q 'bin/rails s\\|rails server\\|Listening on'", current_session)
	local rails_running = os.execute(check_rails_cmd) == 0

	if rails_running then
		-- Rails is running, restart it
		vim.notify("Restarting Rails server...", vim.log.levels.INFO)

		-- First, kill any existing Rails server process
		local kill_cmd = "pkill -f 'bin/rails s' 2>/dev/null || true"
		os.execute(kill_cmd)

		-- Also send Ctrl+C to stop current server in the server window
		local stop_cmd = string.format("tmux send-keys -t %s:server C-c", current_session)
		os.execute(stop_cmd)

		-- Send escape to exit any terminal mode, then close the buffer
		vim.defer_fn(function()
			local escape_cmd = string.format("tmux send-keys -t %s:server Escape", current_session)
			os.execute(escape_cmd)

			-- Close the terminal buffer
			local close_cmd = string.format("tmux send-keys -t %s:server ':bd!' Enter", current_session)
			os.execute(close_cmd)

			-- Wait a moment then start fresh terminal
			vim.defer_fn(function()
				local term_cmd = string.format("tmux send-keys -t %s:server ':term bin/rails s' Enter", current_session)
				os.execute(term_cmd)

				-- Check for common errors after a delay
				vim.defer_fn(function()
					CheckRailsServerStatusInTmux(current_session)
				end, 3000)
			end, 500)
		end, 1000)
	else
		-- Rails not running, start it in server window's Neovim
		vim.notify("Starting Rails server...", vim.log.levels.INFO)

		-- Send the terminal command to server window's Neovim
		local term_cmd = string.format("tmux send-keys -t %s:server ':term bin/rails s' Enter", current_session)
		os.execute(term_cmd)

		-- Check for common errors after a delay
		vim.defer_fn(function()
			CheckRailsServerStatusInTmux(current_session)
		end, 3000)
	end
end

-- Function to check Rails server status in tmux server window
function CheckRailsServerStatusInTmux(session)
	-- Capture the output from server window
	local capture_cmd = string.format("tmux capture-pane -t %s:server -p", session)
	local handle = io.popen(capture_cmd)
	if not handle then
		return
	end

	local output = handle:read("*a")
	handle:close()

	-- Check for common error patterns
	if output:match("bundle install") or output:match("Gemfile") then
		vim.notify("❌ Rails server failed: Run 'bundle install'", vim.log.levels.WARN)
	elseif output:match("syntax error") or output:match("SyntaxError") then
		vim.notify("❌ Rails server failed: Syntax error in code", vim.log.levels.ERROR)
	elseif output:match("pending migration") or output:match("run.*db:migrate") then
		vim.notify("❌ Rails server failed: Run 'rails db:migrate'", vim.log.levels.WARN)
	elseif output:match("Listening on") or output:match("Use Ctrl-C to stop") then
		vim.notify("✅ Rails server started successfully", vim.log.levels.INFO)
	elseif output:match("Address already in use") or output:match("port.*already") then
		vim.notify("❌ Rails server failed: Port already in use", vim.log.levels.ERROR)
	elseif output:match("Could not find") and output:match("gem") then
		vim.notify("❌ Rails server failed: Missing gem - run 'bundle install'", vim.log.levels.WARN)
	end
end

map("n", "<leader>rs", ":lua ManageRailsServer()<CR>", { noremap = true, desc = "Manage Rails server" })

-- Function to manage Angular server in tmux server window
function ManageAngularServer()
	local current_session = vim.fn.system("tmux display-message -p '#S' 2>/dev/null"):gsub("\n", "")
	if current_session == "" then
		vim.notify("Not in a tmux session", vim.log.levels.ERROR)
		return
	end

	-- Check if server window exists in tmux, create if not
	local check_server_cmd = string.format("tmux list-windows -t %s -F '#{window_name}' 2>/dev/null | grep -q '^server$'", current_session)
	local has_server = os.execute(check_server_cmd) == 0

	if not has_server then
		-- Create server window in tmux
		local create_cmd = string.format("tmux new-window -t %s -n server", current_session)
		os.execute(create_cmd)
		vim.notify("Created server window", vim.log.levels.INFO)
	end

	-- Check if Angular server is already running in server window
	local check_angular_cmd = string.format("tmux capture-pane -t %s:server -p | grep -q 'npm run start-local\\|Angular Live Development Server\\|webpack compiled\\|Local:'", current_session)
	local angular_running = os.execute(check_angular_cmd) == 0

	if angular_running then
		-- Angular is running, restart it
		vim.notify("Restarting Angular server...", vim.log.levels.INFO)

		-- Send Ctrl+C to stop current server in the server window
		local stop_cmd = string.format("tmux send-keys -t %s:server C-c", current_session)
		os.execute(stop_cmd)

		-- Send escape to exit any terminal mode, then close the buffer
		vim.defer_fn(function()
			local escape_cmd = string.format("tmux send-keys -t %s:server Escape", current_session)
			os.execute(escape_cmd)

			-- Close the terminal buffer
			local close_cmd = string.format("tmux send-keys -t %s:server ':bd!' Enter", current_session)
			os.execute(close_cmd)

			-- Kill any Node processes on port 4200
			local kill_port_cmd = "lsof -ti:4200 | xargs kill -9 2>/dev/null || true"
			os.execute(kill_port_cmd)

			-- Kill any remaining Angular/Node server processes
			local kill_cmd = "pkill -9 -f 'node.*start-local' 2>/dev/null || true"
			os.execute(kill_cmd)

			-- Wait longer for processes to fully terminate
			vim.defer_fn(function()
				-- Double check and kill any lingering processes on port 4200
				local final_kill_cmd = "lsof -ti:4200 | xargs kill -9 2>/dev/null || true"
				os.execute(final_kill_cmd)

				-- Wait a bit more then start fresh terminal
				vim.defer_fn(function()
					local term_cmd = string.format("tmux send-keys -t %s:server ':term npm run start-local' Enter", current_session)
					os.execute(term_cmd)

					-- Check for common errors after a delay
					vim.defer_fn(function()
						CheckAngularServerStatusInTmux(current_session)
					end, 5000)
				end, 1000)
			end, 2000)
		end, 1000)
	else
		-- Angular not running, start it in server window's Neovim
		vim.notify("Starting Angular server...", vim.log.levels.INFO)

		-- Send the terminal command to server window's Neovim
		local term_cmd = string.format("tmux send-keys -t %s:server ':term npm run start-local' Enter", current_session)
		os.execute(term_cmd)

		-- Check for common errors after a delay
		vim.defer_fn(function()
			CheckAngularServerStatusInTmux(current_session)
		end, 5000)
	end
end

-- Function to check Angular server status in tmux server window
function CheckAngularServerStatusInTmux(session)
	-- Capture the output from server window
	local capture_cmd = string.format("tmux capture-pane -t %s:server -p", session)
	local handle = io.popen(capture_cmd)
	if not handle then
		return
	end

	local output = handle:read("*a")
	handle:close()

	-- Check for common error patterns
	if output:match("EADDRINUSE") or output:match("address already in use") then
		vim.notify("⚠️ Angular server port conflict - another server may be running", vim.log.levels.WARN)
	elseif output:match("Cannot find module") or output:match("Module not found") then
		vim.notify("❌ Angular server failed: Missing dependencies - run 'npm install'", vim.log.levels.WARN)
	elseif output:match("webpack compiled") or output:match("Local:.*http") then
		vim.notify("✅ Angular server started successfully", vim.log.levels.INFO)
	elseif output:match("Error:") or output:match("Failed to") then
		vim.notify("❌ Angular server failed to start - check the server window for details", vim.log.levels.WARN)
	end
end

map("n", "<leader>ns", ":lua ManageAngularServer()<CR>", { noremap = true, desc = "Manage Angular server" })

-- Function to create ai_cli window in current tmux session
function CreateAICliWindow()
	local current_session = vim.fn.system("tmux display-message -p '#S' 2>/dev/null"):gsub("\n", "")
	if current_session == "" then
		vim.notify("Not in a tmux session", vim.log.levels.ERROR)
		return
	end

	-- Check if ai_cli window already exists
	local check_cmd = string.format("tmux list-windows -t %s -F '#{window_name}' 2>/dev/null | grep -q '^ai_cli$'", current_session)
	local has_ai_cli = os.execute(check_cmd) == 0

	if has_ai_cli then
		vim.notify(string.format("ai_cli window already exists in session '%s'", current_session), vim.log.levels.WARN)
		return
	end

	-- Prompt for AI choice
	vim.ui.select(
		{"claude", "gemini"},
		{prompt = string.format("Create ai_cli window in '%s' with:", current_session)},
		function(choice)
			if choice then
				local create_cmd = string.format("tmux new-window -t %s -n ai_cli %s", current_session, choice)
				local result = os.execute(create_cmd)

				if result == 0 then
					vim.notify(string.format("Created ai_cli window with %s in session '%s'", choice, current_session), vim.log.levels.INFO)
				else
					vim.notify("Failed to create ai_cli window", vim.log.levels.ERROR)
				end
			end
		end
	)
end


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
