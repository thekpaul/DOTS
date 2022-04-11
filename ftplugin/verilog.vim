" Only Execute when File Type is Verilog
if (&ft != 'verilog')
    finish
endif

inoremap <buffer> /* /**/<left><left>

setlocal shiftwidth=2 | setlocal tabstop=2
setlocal softtabstop=2 | setlocal smarttab | "Set Tab Spacing to 2
