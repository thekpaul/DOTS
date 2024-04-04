--[=[
	VIMTEX.lua:
	Configurations for the `lervag/vimtex` Plugin.
	Ported and extended from original configurations in legacy vimscript.
]=]

return {
	'lervag/vimtex',
 --	ft = "tex", -- Load on startup for global functions!
	init = function()
		vim.g.vimtex_indent_enabled = false
		vim.g.vimtex_view_general_viewer = 'wslview' -- TODO: Change for other OSes!
	 --	vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
	 --	vim.g.vimtex_compiler_method = 'generic'
	 --	vim.g.vimtex_compiler_generic = { 'command' : 'make' }
		vim.g.vimtex_imaps_enabled = false
	 --	vim.g.vimtex_imaps_leader = '@' -- TODO: Check how `imaps` work when enabled!
	end
}
