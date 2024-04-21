" Detecting Custom Filetypes!

" Listed Filetypes :
	" MATLAB Script(*.mlx)

if exists("did_load_filetypes")
	finish
endif

augroup filetypedetect
	au! BufRead,BufNewFile *.h    setfiletype c
	au! BufRead,BufNewFile *.mlx  setfiletype matlabscript
	au! BufRead,BufNewFile *.fish setfiletype fish
augroup END
