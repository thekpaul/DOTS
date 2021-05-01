" INIT.vim: Initialising Configuration for NeoVim

" Allow the usage of mouse in all environments
set mouse=a

" Partial Behaviour Changes
behave mswin
set virtualedit=onemore "For Consistency in Selective AutoClosing

" Windows like clipboard
vnoremap <c-x> "+x
vnoremap <c-c> "+y
cnoremap <c-v> <c-r>+
exe 'ino <script> <C-V>' paste#paste_cmd['i']

" Un/Redo Like Windows
nnoremap <C-z> u
nnoremap <C-y> <C-r>
inoremap <C-z> <Esc>ui
inoremap <C-y> <Esc><C-r>i
"
" Save Like Windows
inoremap <C-s> <Esc>:%s/\s\+$//e<CR>:let @/=""<CR>:update<CR>a
nnoremap <C-s> :%s/\s\+$//e<CR>:let @/=""<CR>:update<CR>

" delete, yank, select a document
nnoremap dad ggVGd
nnoremap yad %y
nnoremap vad ggVG

set noundofile | "No Undo Files

" Source Plugin Vimscript
filetype off
filetype plugin indent on | "Set plugin loading according to filetype

set guifont=D2Coding:h10
set encoding=utf8 | "Set File Encoding as UTF-8
language en
let $LANG = 'en_US'
runtime delmenu.vim
runtime menu.vim
set langmenu=en_US.utf8 | "Set Menu Language
set fileencodings=utf8 | "Set NEW File Encoding to UTF-8
    if (&fileencodings != 'utf8')
        set fileencodings=utf8
    endif | "Set ALL File Encoding to UTF-8
set number | "Line Numbering
set linespace=3 | "Set Line Spacing to 3 units
set expandtab | set shiftwidth=4 | set tabstop=4
set softtabstop=4 | set smarttab | "Set Tab Spacing
set cursorline
augroup CursorColumn
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
    au WinLeave * setlocal nocursorcolumn
augroup END
set breakindent | set linebreak
set iskeyword+=\
let g:tex_flavor = "latex"
set colorcolumn=80
set splitbelow | set splitright | "Split below and right of current buffer
set foldmethod=manual | "Fold Manually
