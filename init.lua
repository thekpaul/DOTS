--[=[
	INIT.lua: Initialising Configurations for NeoVim in Lua.
	Ported and extended from original configurations in legacy vimscript.
]=]

-- Use Local `.vimrc`s and Set a Security Option
vim.opt.exrc = true
vim.opt.secure = true

-- Behaviour changes to `mswin`
vim.opt.selection  = 'exclusive'
vim.opt.selectmode = { 'mouse', 'key' }
vim.opt.mousemodel = 'popup'
vim.opt.keymodel   = { 'startsel', 'stopsel' }

-- Virtual Edits
vim.opt.virtualedit = 'onemore' -- For Consistency in Selective AutoClosing

-- Mouse usage
vim.o.mouse = 'a'

-- Select-mode Windows-like clipboard
vim.cmd [[
	vnoremap <C-x> "+x
	vnoremap <C-c> "+y
	cnoremap <C-v> <C-r>+
	exe 'ino <script> <C-V>' paste#paste_cmd['i']
]]

-- Windows-like un/redo
vim.cmd [[
	nnoremap <C-z> u
	nnoremap <C-y> <C-r>
	inoremap <C-z> <Esc>ui
	inoremap <C-y> <Esc><C-r>i
]]

-- Saving without whitespaces | TODO: Fix reset of `/` register
vim.cmd [[
	inoremap <C-s> <Esc>:%s/\s\+$//e<CR>:let @/=""<CR>:update<CR>a
	nnoremap <C-s> :%s/\s\+$//e<CR>:let @/=""<CR>:update<CR>
]]

-- Delete, yank, select a document
vim.cmd [[
	nnoremap dad ggVGd
	nnoremap yad %y
	nnoremap vad ggVG
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
	tab   = "I->",
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

" PLUGINS with Vim-Plug as Plugin Manager {

	call plug#begin(stdpath('config') . '/plugged')
		Plug 'mhinz/vim-startify', { 'on':  'Startify' }
		Plug 'nvim-tree/nvim-web-devicons'
		Plug 'romgrk/barbar.nvim'
		Plug 'tpope/vim-fugitive'
		Plug 'vim-airline/vim-airline'
		Plug 'junegunn/seoul256.vim'
		Plug 'preservim/vim-indent-guides'
		Plug 'tpope/vim-surround'
		Plug 'wakatime/vim-wakatime'
		Plug 'lervag/vimtex'
		Plug 'SirVer/ultisnips'
	call plug#end()

" }

]]

-- Vim-Plug Custom Mappings
require('mapping.plug')

-- BarBar: Buffer/Tabline
require('plugins.barbar')
require('mapping.barbar')

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
