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

	-- Scroll Off
	vim.opt.scrolloff = 10

	-- Providers
	vim.g.loaded_perl_provider = 0

	-- Default LaTeX Flavor
	vim.g.tex_flavor = "latex"

	-- TODO: Function/Mapping to change LEADING (SPACES <=> TABS)

	-- Legacy Vimscript Configurations from `init.vim`

	vim.cmd [[
	autocmd VimEnter,Colorscheme * :hi Comment gui=italic
	au! BufRead,BufNewFile *.h setfiletype c

	" Jump Mechanism
	nnoremap <silent> <C-j> /<++><CR>:let @/ = ""<CR>4"_xi
	inoremap <silent> <C-j> <Esc>/<++><CR>:let @/ = ""<CR>4"_xi

	" AutoClose {

	inoremap ( ()<lt>++><Esc>5ha
	inoremap [ []<lt>++><Esc>5ha
	inoremap { {}<lt>++><Esc>5ha
	inoremap {<CR> {<CR>}<ESC>O
	inoremap {;<CR> {<CR>};<ESC>O
	if (&ft != 'tex')
		if (&ft != 'verilog')
			inoremap ' ''<lt>++><Esc>5ha
		endif
		inoremap ` ``<lt>++><Esc>5ha
		inoremap " ""<lt>++><Esc>5ha
	endif

	vmap ( di(<Esc>p
	vmap [ di[<Esc>p
	vmap { di{<Esc>p
	vmap {<CR> di{<CR><Esc>p
	vmap {;<CR> di{;<CR><Esc>p
	if (&ft != 'tex')
		if (&ft != 'verilog')
			vmap ' di'<Esc>p
		endif
		vmap ` di`<Esc>p
		vmap " di"<Esc>p
	endif

	" }

	]]

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

	-- Plugins and options go HERE:
	require("lazy").setup({
		{
			'junegunn/seoul256.vim',
			lazy = false,
			priority = 1000
		},
		{
			'mhinz/vim-startify',
			cmd = "Startify"
		},
		{
			'nvim-tree/nvim-web-devicons',
			lazy = true -- API plugin!
		},
		{
			'romgrk/barbar.nvim',
			dependencies = {
				'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
				'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
			},
			init = function() vim.g.barbar_auto_setup = false end,
		},
		'tpope/vim-fugitive',
		'vim-airline/vim-airline',
		{
			'preservim/vim-indent-guides',
			init = function() vim.g.indent_guides_enable_on_vim_startup = true end,
		},
		'tpope/vim-surround',
		'wakatime/vim-wakatime',
		{
			'lervag/vimtex',
			ft = "tex"
		},
		{
			'SirVer/ultisnips',
			ft = "tex" -- Snippets are currently only impelemted for TeX files
		},
		{
			'nvim-treesitter/nvim-treesitter',
			build = ":TSUpdate",
			commit = "25ed904c7522b34ea2d1d01e598067b6fd4d037e", -- Before breaking change for latex
		 --	config = function ()
		 --		require("nvim-treesitter.configs").setup({
		 --			ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
		 --			sync_install = false,
		 --			highlight = { enable = true },
		 --			indent = { enable = true },
		 --		})
		 --	end
		},
		'mhinz/vim-signify',
		{ url = 'https://tpope.io/vim/abolish.git'},
	})

	-- BarBar: Buffer/Tabline
	require('plugins.barbar')

	-- Vim-Airline: Lightweight Statusline
	require('plugins.vim-airline')

	-- Seoul256: Colorscheme
	require('plugins.seoul256')

	-- VimTeX: LaTeX with (Neo)Vim
	require('plugins.vimtex')

	-- Startify: Startup Screen
	require('plugins.startify')

	-- Vim-Indent-Guides: Vertical Indent Guide ColorColumns
	require('plugins.vim-indent-guides')

	-- UltiSnips: Snippets Engine
	require('plugins.ultisnips')

	-- NVim-Treesitter: Parsing Library
	require('plugins.treesitter')

	-- Signify: VCS Indicators in (N)Vim Line-number Sidebar
	require('plugins.signify')

end
