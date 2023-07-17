--[=[
	MAPPING_BARBAR.lua:
	Mappings for the `romgrk/barbar.nvim` Plugin.
	Ported and extended from original configurations in legacy vimscript.
]=]

vim.cmd [[
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