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

if not vim.g.vscode then
	-- Mouse usage
	vim.o.mouse = 'a'

	-- Saving without whitespaces | TODO: Fix reset of `/` register
	vim.cmd [[
		inoremap <C-s> <Esc>:%s/\s\+$//e<CR>:let @/=""<CR>:update<CR>a
		nnoremap <C-s> :%s/\s\+$//e<CR>:let @/=""<CR>:update<CR>
	]]

	-- Undo files
	vim.opt.undofile = false

	-- Set plugin loading according to filetype
	vim.cmd [[
		filetype off
		filetype plugin indent on
	]]

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
		tab   = " ",
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

	-- Global mappings
	-- Jump
	local map = vim.keymap.set
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
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)

	-- Plugin configuration modules are in the `lua/plugins` subdirectory
	require("lazy").setup("plugins", {
		-- LAZY.nvim options
		change_detection = {
			notify = false, -- Don't notify when plugin configurations change
		},
	})

	-- Show comments as ITALIC (works well with cursive fonts)
	--   -> Apply AFTER Colorscheme!
	local oldComment = vim.api.nvim_get_hl(0, { name = "Comment" })
	local newComment = vim.tbl_extend('force',
		{}, -- Baseline empty table to fill necessary key-value pairs
		oldComment, -- Get all pairs from original `Comment` group
		{ italic = true } -- Overwrite as italics
	)

	vim.api.nvim_set_hl(0, "Comment", newComment)

end
