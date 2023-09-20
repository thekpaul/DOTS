" Only Execute when File Type is Verilog
if (&ft != 'verilog')
    finish
endif

inoremap <buffer> /* /**/<left><left>
inoremap <buffer> ' '

setlocal shiftwidth=4 | setlocal tabstop=4 | setlocal noexpandtab
setlocal softtabstop=4 | setlocal smarttab | "Set Tab Spacing to 4
