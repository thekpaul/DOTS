" Jump Mechanism
nnoremap <silent> <C-j> /<++><CR>:let @/ = ""<CR>4"_xi
inoremap <silent> <C-j> <Esc>/<++><CR>:let @/ = ""<CR>4"_xi

" Set Mappings for Vimscript and Vanilla Vim Management
nnoremap <F1> :cd $XDG_CONFIG_HOME/nvim<CR>:e init.vim<CR>
    "Press F1 to Open User init.vim
nnoremap <C-F1> :cd $VIM<CR>:e sysinit.vim<CR>
    "Press Ctrl+F1 to Open System sysinit.vim
nnoremap <S-F1> :cd $XDG_CONFIG_HOME/nvim<CR>:split init.vim<CR>
    "Press Shift+F1 to Split-Open User init.vim
nnoremap v<S-F1> :cd $XDG_CONFIG_HOME/nvim<CR>:vsplit init.vim<CR>
    "Press V and Shift+F1 to VSplit-Open User init.vim
nnoremap <F2> :tabe $XDG_CONFIG_HOME/nvim/init.vim<CR>:cd %:p:h<CR>
    "Press F2 to Open User init.vim in New Tab
nnoremap <C-F2> :tabe $VIM/sysinit.vim<CR>:cd %:p:h<CR>
    "Press Ctrl+F2 to Open System sysinit.vim in New Tab
nnoremap <F3> :cd %:p:h<CR>
    "Press F3 to Change Working Directory to Current File
nnoremap <C-F3> :tcd %:p:h<CR>
    "Press Ctrl+F3 to Change Working Directory to Current File for Current Tab
nnoremap <S-F3> :cd ..<CR>
    "Press Shift+F3 to Change Working Directory to One Level Up
nnoremap <F4> :call delete(expand('%'))<CR>
    "Press F4 to delete Current File
nnoremap <S-F4> :call delete(expand('%<').'.log')<CR>
    "Press Shift+F4 to delete Current File
nnoremap <C-F4> :call delete(expand('%'))<CR>:bdelete!<CR>
    "Press Ctrl+F4 to delete Current File and quit buffer
"F5 is universally reserved for Compiling and Executing Various Code
"F6 is universally reserved for Auxiliary Tasks related to Compilation
"F7 is not (yet) assigned for a mapping.
"F8 is not (yet) assigned for a mapping.
nnoremap <F9> :tabe<CR>:terminal<CR>a
    "Press F9 to OPEN NEW TAB to TERMINAL
nnoremap <C-F9> :terminal<CR>a
    "Press Ctrl+F9 to change CURRENT buffer to TERMINAL
nnoremap <F10> :up<CR>:source $XDG_CONFIG_HOME/nvim/init.vim<CR>
    "Press F10 to Save and Reload User NVIMRC
nnoremap <C-F10> :up<CR>:execute "so $XDG_CONFIG_HOME/nvim/ftplugin/".&ft.".vim"<CR>
    "Press Ctrl+F10 to Save and Reload User FT_NVIMRC
nnoremap <C-S-F10> :up<CR>:tabe "so $XDG_CONFIG_HOME/nvim/ftplugin/".&ft.".vim"<CR>
    "Press Ctrl+Shift+F10 to Save and Open User FT_NVIMRC in New Tab

" AutoClose
inoremap ( ()<lt>++><Esc>5ha
inoremap [ []<lt>++><Esc>5ha
inoremap { {}<lt>++><Esc>5ha
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
if (&ft != 'tex')
    inoremap ' ''<lt>++><Esc>5ha
    inoremap ` ``<lt>++><Esc>5ha
    inoremap " ""<lt>++><Esc>5ha
endif

" AutoClose in Selection
vmap ( di(<Esc>p
vmap [ di[<Esc>p
vmap { di{<Esc>p
vmap {<CR> di{<CR><Esc>p
vmap {;<CR> di{;<CR><Esc>p
if (&ft != 'tex')
    vmap ' di'<Esc>p
    vmap ` di`<Esc>p
    vmap " di"<Esc>p
endif
