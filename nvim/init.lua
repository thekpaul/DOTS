--[=[
    INIT.lua: Initialising Configurations for NeoVim in Lua.
    Ported and extended from original configurations in legacy vimscript.
]=]

-- Use Local `.vimrc`s and Set a Security Option
vim.opt.exrc = true
vim.opt.secure = true

-- Behaviour changes to `mswin`
vim.cmd [[ behave mswin ]]

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
vim.cmd [[
    " nnoremap <F12> :PlugInstall<CR>  | " Press F12 to Install new Plugins
    " nnoremap <C-F12> :PlugClean<CR>  | " Press Ctrl+F12 to Delete Plugins
    " nnoremap <S-F12> :PlugUpdate<CR> | " Press Shift+F12 to Update new Plugins
]]

-- BarBar: Buffer/Tabline
require('plugins.barbar')
vim.cmd [[
    " Temporary custom highlight groups
    autocmd VimEnter,Colorscheme *
        \ :hi BufferTabpageFill guibg=#565656
    autocmd VimEnter,Colorscheme *
        \ :hi BufferTabpages    guibg=#565656 guifg=#ffffff
    autocmd VimEnter,Colorscheme *
        \ :hi BufferTabpagesSep guibg=#565656 guifg=#ffffff

    " BarBar Mappings
    " Move to previous/next
    nnoremap <silent> ,, :BufferPrevious<CR>
    nnoremap <silent> ,. :BufferNext<CR>
    " Re-order to previous/next
    nnoremap <silent> ,< :BufferMovePrevious<CR>
    nnoremap <silent> ,> :BufferMoveNext<CR>
    " Goto buffer in position...
    nnoremap <silent> ,1 :BufferGoto 1<CR>
    nnoremap <silent> ,2 :BufferGoto 2<CR>
    nnoremap <silent> ,3 :BufferGoto 3<CR>
    nnoremap <silent> ,4 :BufferGoto 4<CR>
    nnoremap <silent> ,5 :BufferGoto 5<CR>
    nnoremap <silent> ,6 :BufferGoto 6<CR>
    nnoremap <silent> ,7 :BufferGoto 7<CR>
    nnoremap <silent> ,8 :BufferGoto 8<CR>
    nnoremap <silent> ,9 :BufferLast<CR>
    " Pin/unpin buffer
    nnoremap <silent> ,p :BufferPin<CR>
    " Close buffer
    nnoremap <silent> ,c :BufferClose<CR>
    " Wipeout buffer :BufferWipeout<CR>
    " Magic buffer-picking mode :BufferPick<CR>
    " Close commands
    " - :BufferCloseAllButCurrent<CR>
    " - :BufferCloseAllButPinned<CR>
    " - :BufferCloseAllButCurrentOrPinned<CR>
    " - :BufferCloseBuffersLeft<CR>
    " - :BufferCloseBuffersRight<CR>
    " Sort automatically by...
    nnoremap <silent> ,bb :BufferOrderByBufferNumber<CR>
    nnoremap <silent> ,bd :BufferOrderByDirectory<CR>
    nnoremap <silent> ,bl :BufferOrderByLanguage<CR>
    nnoremap <silent> ,bw :BufferOrderByWindowNumber<CR>
]]

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