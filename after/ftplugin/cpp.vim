" Only Execute when File Type is C
if (&ft != 'cpp') | finish | endif

setlocal shiftwidth=4 | setlocal tabstop=4 | setlocal noexpandtab
setlocal softtabstop=4 | setlocal smarttab | "Set Tab Spacing to 4

inoreabb <silent> <buffer> #inc<lt> #include <lt>><left><C-R>
nnoremap <buffer> #inc<lt> i#include <lt>><left>
nnoremap <buffer> #inc" i#include ""<left>
inoreabb <silent> <buffer> #d #define <C-R>
nnoremap <buffer> #d i#define
inoremap <buffer> /* /**/<left><left>
inoreabb <buffer> cout cout <lt><lt>
