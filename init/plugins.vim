" Vim-Plug as Plugin Manager
call plug#begin('/home/thekpaul/.config/nvim/plugged')
    Plug 'mhinz/vim-startify' | " Installed Vim-Startify
    Plug 'scrooloose/nerdtree' | " Installed NERDTree
    Plug 'tpope/vim-fugitive' | "Installed vim-fugitive, a Git wrapper
    Plug 'vim-airline/vim-airline' | " Installed Vim-Airline
    Plug 'junegunn/seoul256.vim' | " Installed Seoul256 Theme
    Plug 'nathanaelkane/vim-indent-guides'
        " Installed vim-indent-guides, a visual indentation guide
    Plug 'plasticboy/vim-markdown' | "Installed vim-markdown
    Plug 'tpope/vim-surround' | "Installed vim-surround
call plug#end()

" Additional Settings for each External Plugin

" Additional Settings for the Vim-Plug Plugin
nnoremap <F12> :PlugInstall<CR>
    " Press F12 to Install new Plugins
nnoremap <C-F12> :PlugClean<CR>
    " Press Ctrl+F12 to Delete Plugins
nnoremap <S-F12> :PlugUpdate<CR>
    " Press Shift+F12 to Update new Plugins

" Additional Settings for the Seoul256 Plugin
let g:seoul256_background = 235
colo seoul256
highlight EndOfBuffer guifg=bg | "Hide Tildes in Empty Buffer Space for GUI
highlight EndOfBuffer ctermfg=bg | "Hide Tildes for Terminal

" Additional Settings for the Startify Plugin
nnoremap <F11> :Startify<CR>
    " Press F11 to Startify current buffer
nnoremap <C-F11> :tabe<CR>:Startify<CR>
    " Press Ctrl+F11 to Startify new tab
let g:startify_custom_header = [
\ '                                              __ __                        ',
\ '                            __               /\ \\ \                       ',
\ '                   __   __ /\_\    ___ ___   \ \ \\ \                      ',
\ '                  /\ \ /\ \\/\ \ /` __` __`\  \ \ \\ \                     ',
\ '                  \ \ \_/ / \ \ \/\ \/\ \/\ \  \ \_\\_\                    ',
\ '                   \ \___/   \ \_\ \_\ \_\ \_\  \/\_\\_\                   ',
\ '                    \/__/     \/_/\/_/\/_/\/_/   \/_//_/                   ',
\ '                                                                           ',
\ '                                                                           ',
\ '                     ___                         ___                       ',
\ '                        \      / \  \   /\      /                          ',
\ '                         \    ㅣ       / ㅣ    /                           ',
\ '                          \___ \    __/  / ___/                            ',
\ '                                                                           ',
\ '                                                                           ']
set sessionoptions=blank,curdir,folds,help,tabpages,winpos
    " Startify respects Preset Values of the Preceding Options

" Additional Settings for the NERDTree Plugin
let g:NERDTreeMinimalUI = 1
let g:NERDTreeWinSize = 25
autocmd VimEnter * NERDTree $HOME | wincmd l
autocmd BufEnter * if (!exists("t:NERDTreeBufName") ) | silent NERDTreeMirror | wincmd l | endif
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Additional Settings for the vim-indent-guides Plugin
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'startify']

" Vim-Markdown
let g:vim_markdown_folding_disabled = 1
