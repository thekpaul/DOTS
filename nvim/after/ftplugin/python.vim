" Only Execute when File Type is Python
if (&ft != 'python')
    finish
endif

set shiftwidth=2
set tabstop=2
set softtabstop=2
set smarttab | "Set Tab Spacing to 2

" Next Line Comment
" TODO: Insert-mode Map

" For Single-File Codes : Save, Compile and Run
nnoremap <buffer> <F5> :cd %:p:h<CR>:w<CR>:tabe %<CR>:terminal py %<CR>a
nnoremap <buffer> <S-F5> :cd %:p:h<CR>:w<CR>:!py %<CR>
nnoremap <buffer> <C-F5> :cd %:p:h<CR>:tabe %<CR>:terminal py %<CR>a

" TODO: Multi-File Codes that require a Makefile
