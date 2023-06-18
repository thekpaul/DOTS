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
        Plug 'mhinz/vim-startify', { 'on':  'Startify' } " Vim-Startify
        Plug 'nvim-tree/nvim-web-devicons' | " Devicons for NeoVim
        Plug 'romgrk/barbar.nvim' " Tabline Plugin
        Plug 'tpope/vim-fugitive' " Git Wrapper
        Plug 'vim-airline/vim-airline' " Light Statusline
        Plug 'junegunn/seoul256.vim' " Seoul256 Theme
        Plug 'preservim/vim-indent-guides' " Visual Indentation Guide
        Plug 'tpope/vim-surround' " Surrounder Plugin
        Plug 'wakatime/vim-wakatime' " Official WakaTime Plugin
        Plug 'lervag/vimtex' " Plugin for LaTeX
        Plug 'SirVer/ultisnips' " Snippet Engine Plugin
    call plug#end()

" }

" ADDITIONAL SETTINGS for each External Plugin {

  " Vim-Plug {

      " nnoremap <F12> :PlugInstall<CR>
      "   " Press F12 to Install new Plugins
      " nnoremap <C-F12> :PlugClean<CR>
      "   " Press Ctrl+F12 to Delete Plugins
      " nnoremap <S-F12> :PlugUpdate<CR>
      "   " Press Shift+F12 to Update new Plugins

  " }

  " BarBar {

      " Source `lua/my_barbar.lua` for Setup
        lua require('plugins.barbar')

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

  " }

  " VimTeX {

        let g:vimtex_indent_enabled = 0
      " let g:vimtex_view_general_viewer = '.local/bin/sumatrapdf.sh'
      " let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
      " let g:vimtex_compiler_method = 'generic'
      " let g:vimtex_compiler_generic = { 'command' : 'make' }

  " }

  " Seoul256 {

        let g:seoul256_background = 234
        colo seoul256
        highlight EndOfBuffer guifg=bg | "Hide Tildes in Empty Buffer Space for GUI
        highlight EndOfBuffer ctermfg=bg | "Hide Tildes for Terminal

  " }

  " Startify {

        let g:startify_custom_header = [
        \ '                                         __ __                  ',
        \ '                       __               /\ \\ \                 ',
        \ '              __   __ /\_\    ___ ___   \ \ \\ \                ',
        \ '             /\ \ /\ \\/\ \ /` __` __`\  \ \ \\ \               ',
        \ '             \ \ \_/ / \ \ \/\ \/\ \/\ \  \ \_\\_\              ',
        \ '              \ \___/   \ \_\ \_\ \_\ \_\  \/\_\\_\             ',
        \ '               \/__/     \/_/\/_/\/_/\/_/   \/_//_/             ',
        \ '                                                                ']
        set sessionoptions=blank,curdir,folds,help,tabpages,winpos
          " Startify respects Preset Values of the Preceding Options

  " }

  " Vim-indent-guides {

        let g:indent_guides_enable_on_vim_startup = 1
        let g:indent_guides_guide_size = 1
        let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'startify']

      " Manually Set Foreground Colors matching `lcs` Tabs in Indent Guides {

            let g:indent_guides_auto_colors = 0
            autocmd VimEnter,Colorscheme *
                \ :hi IndentGuidesOdd  ctermfg=59 guifg=#727272
            autocmd VimEnter,Colorscheme *
                \ :hi IndentGuidesEven ctermfg=59 guifg=#727272

      " }

  " }

  " Vim-Markdown {

        let g:vim_markdown_folding_disabled = 1

  " }

  " UltiSnips {

        let g:UltiSnipsExpandTrigger = "<tab>"
        let g:UltiSnipsJumpForwardTrigger = "<tab>"
        let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
        let g:UltiSnipsSnippetDirectories = [stdpath('config') . "/UltiSnips"]

  " }

" }

]]
