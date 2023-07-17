--[=[
	PLUGINS_VIM-INDENT-GUIDES.lua:
	Configurations for the `preservim/vim-indent-guides` Plugin.
	Ported and extended from original configurations in legacy vimscript.
]=]

vim.g.indent_guides_enable_on_vim_startup = true
vim.g.indent_guides_guide_size = 1
vim.g.indent_guides_exclude_filetypes = { 'help', 'startify' }

-- Manually Set Foreground Colors matching `lcs` Tabs in Indent Guides
vim.g.indent_guides_auto_colors = false
vim.cmd [[
	autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermfg=59 guifg=#727272
	autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermfg=59 guifg=#727272
]]