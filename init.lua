--[=[
	INIT.lua: Initialising Configurations for NeoVim in Lua.
	Ported and extended from original configurations in legacy vimscript.
]=]

-- Use Local `.vimrc`s and Set a Security Option
vim.opt.exrc = true
vim.opt.secure = true

--[=[
	NOTE: This configuration is sourced in both vanilla NeoVim and VS Code,
	via the "VSCode Neovim" extension. As such, all prior settings are now
	wrapped in a conditional statement to check for VS Code usage by default.
	This will be sorted in future commits to replicate the current Neovim
	setup in VS Code as well.
]=]

-- Behaviour changes to `mswin`
vim.opt.selection  = 'exclusive'
vim.opt.selectmode = { 'mouse', 'key' }
vim.opt.mousemodel = 'popup'
vim.opt.keymodel   = { 'startsel', 'stopsel' }

-- Virtual Edits
vim.opt.virtualedit = 'onemore' -- For Consistency in Selective AutoClosing

-- Default Filetypes
vim.g.filetype_v = 'verilog' -- Default filetype for `*.v` is "verilog"

if not vim.g.vscode then
	-- Mouse usage
	vim.o.mouse = 'a'

	-- Undo files
	vim.opt.undofile = false

	-- Line numbers
	vim.opt.number = true

	-- Default tab behaviour
	vim.opt.tabstop     = 2
	vim.opt.softtabstop = 2
	vim.opt.shiftwidth  = 2
	vim.opt.expandtab   = true
	vim.opt.smarttab    = true
	vim.opt.autoindent  = true

	-- Line wrapping
	vim.opt.wrap = false
	vim.opt.sidescroll = 8

	-- Search case-sensitivity
	vim.opt.ignorecase = true
	vim.opt.smartcase = true

	-- Current cursor line/column highlighting
	vim.opt.cursorline   = true
	vim.opt.cursorcolumn = true

	-- Respect 24-bit RGB colors in TUI (favours `gui` values over `cterm`)
	vim.opt.termguicolors = true

	-- Show sign column so that text doesn't shift
	-- vim.opt.signcolumn = "yes"

	-- Coloring columns
	vim.opt.colorcolumn = { "80", "120" }

	-- Encoding and Language Settings
	vim.opt.encoding = "utf8"
	vim.opt.fileencodings = "utf8"

	vim.api.nvim_create_autocmd( "UIEnter",
		{
			once = true,
			callback = function()
				vim.cmd [[
					runtime delmenu.vim
					set langmenu=en_US.utf8
					let $LANG = 'en_US'
					runtime menu.vim
				]]
			 -- require "ginit" -- Load GUI settings from separate file
			end
		}
	)

	-- Indentation and Line Breaks
	vim.opt.breakindent = true
	vim.opt.linebreak = true

	-- Add Backslash to Keyword List
	vim.opt.iskeyword:append { '\\' }

	-- Split new panes to right & below
	vim.opt.splitright = true
	vim.opt.splitbelow = true

	-- Fold Method
	vim.opt.foldmethod = "manual"

	-- List and List Characters
	vim.opt.list = true
	vim.opt.listchars = {
		tab   = " ", -- Other options: , , 󰅂
		trail = "X",
	 --	nbsp  = "␣",
	 --	eol   = "↲",
	}

	-- Fill Characters: Set `eob` to empty character to remove EOB tildes
	vim.opt.fillchars = { eob = " " }

	-- Scroll Off
	vim.opt.scrolloff = 10

	-- Providers
	vim.g.loaded_perl_provider = 0

	-- Default LaTeX Flavor
	vim.g.tex_flavor = "latex"

	-- LEADER key
	vim.g.mapleader = " "

	-- Global mappings
	local map = vim.keymap.set
	local mapopts = { remap = false }

	-- Save Without Trailing Whitespaces
	-- {
	local function save_without_trailing_whitespaces()
		local cursor = vim.api.nvim_win_get_cursor(0)
		vim.cmd('keeppatterns %s/\\s\\+$//e')
		vim.cmd.update()
		vim.api.nvim_win_set_cursor(0, cursor)
	end

	mapopts.desc = "Save Without Trailing Whitespaces"
	map({ "n", "i" }, "<C-s>", save_without_trailing_whitespaces, mapopts)
	-- }

	-- Line-wise Move
	-- {
	mapopts.desc = "Move Current Line Down 1 Line"
	map("n", "<M-j>", ":move +1<CR>", mapopts)

	mapopts.desc = "Move Current Line Up 1 Line"
	map("n", "<M-k>", ":move -2<CR>", mapopts)

	mapopts.desc = "Move Selection Down 1 Line"
	map("v", "J", ":move '>+1<CR>gv=gv", mapopts)

	mapopts.desc = "Move Selection Up 1 Line"
	map("v", "K", ":move '<-2<CR>gv=gv", mapopts)
	-- }

	-- Additional line-joining keymap that keeps cursor in place
	-- {
	mapopts.desc = "Keep Cursor in Place While Joining Lines"
	map("n", "<leader>J", "mzJ`z")
	-- }

	-- Keep cursor vertically centered during page-jumping and search
	-- {
	mapopts.desc = "[VCC] Half-page Down"
	map("n", "<C-d>", "<C-d>zz")

	mapopts.desc = "[VCC] Full-page Down"
	map("n", "<C-f>", "<C-f>zz")

	mapopts.desc = "[VCC] Half-page Up"
	map("n", "<C-u>", "<C-u>zz")

	mapopts.desc = "[VCC] Full-page Up"
	map("n", "<C-b>", "<C-b>zz")

	mapopts.desc = "[VCC] Find Next Search"
	map("n", "n", "nzzzv")

	mapopts.desc = "[VCC] Find Previous Search"
	map("n", "N", "Nzzzv")
	-- }

	-- Paste or delete without overwriting local clipboard
	-- {
	mapopts.desc = "Paste to Selection without Overwriting Buffer"
	map("x", "<leader>p", "\"_dP")

	mapopts.desc = "Delete without Overwriting Buffer"
	map({ "n", "v" }, "<leader>d", "\"_d")
	-- }

	-- Easy access to system clipboard
	-- {
	mapopts.desc = "Yank to System Clipboard"
	map({ "n", "v" }, "<leader>y", "\"+y")

	mapopts.desc = "Yank Current Line to System Clipboard"
	map("n", "<leader>Y", "\"+Y")
	-- }

	-- Normal Mode for Terminal Buffer in Neovim
	mapopts.desc = "Return to Normal Mode in Terminal Buffer"
	map("t", "<Esc>", "<C-\\><C-n>")

	-- Jump
	map('n', '<C-j>', '/<++><CR>:let @/ = ""<CR>4"_xi')
	map('i', '<C-j>', '<Esc>/<++><CR>:let @/ = ""<CR>4"_xi')

	-- AutoClose, Insert-mode
	map('i', '(', '()<lt>++><Esc>5ha')
	map('i', '[', '[]<lt>++><Esc>5ha')
	map('i', '{', '{}<lt>++><Esc>5ha')
	map('i', '{<CR>', '{<CR>}<ESC>O')
	map('i', '{;<CR>', '{<CR>};<ESC>O')
	if not (vim.bo.filetype == 'tex') then
		if not (vim.bo.filetype == 'verilog') then
			map('i', "'", "''<lt>++><Esc>5ha")
		end
		map('i', '`', '``<lt>++><Esc>5ha')
		map('i', '"', '""<lt>++><Esc>5ha')
	end

	-- AutoClose, Visual-mode
	map('v', '(', 'di(<Esc>p', { remap = true })
	map('v', '[', 'di[<Esc>p', { remap = true })
	map('v', '{', 'di{<Esc>p', { remap = true })
	map('v', '{<CR>', 'di{<CR><Esc>p', { remap = true })
	map('v', '{;<CR>', 'di{;<CR><Esc>p', { remap = true })
	if not (vim.bo.filetype == 'tex') then
		if not (vim.bo.filetype == 'verilog') then
			map('v', "'", "di'<Esc>p", { remap = true })
		end
		map('v', '`', 'di`<Esc>p', { remap = true })
		map('v', '"', 'di"<Esc>p', { remap = true })
	end

	-- Bootstrap LAZY.nvim as a native Lua plugin manager
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not (vim.uv or vim.loop).fs_stat(lazypath) then
		local lazyrepo = "https://github.com/folke/lazy.nvim.git"
		local out = vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			lazyrepo,
			"--branch=stable", -- latest stable release
			lazypath
		})
		if vim.v.shell_error ~= 0 then
			vim.api.nvim_echo({
				{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
				{ out, "WarningMsg" },
				{ "\nPress any key to exit..." },
			}, true, {})
			vim.fn.getchar()
			os.exit(1)
		end
	end
	vim.opt.rtp:prepend(lazypath)

	-- Plugin configuration modules are in the `lua/plugins` subdirectory
	require("lazy").setup("plugins", {
		-- LAZY.nvim options
		change_detection = {
			notify = false, -- Don't notify when plugin configurations change
		},
	})

	vim.filetype.add({
		pattern = {
			['.*/.*%.cdsinit.*'] = 'skill', -- See `:help lua-patterns`
			['.*ssh/config'] = 'sshconfig'
		}
	})

end
