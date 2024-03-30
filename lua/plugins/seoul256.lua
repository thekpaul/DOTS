--[=[
	PLUGINS_SEOUL256.lua:
	Configurations for the `junegunn/seoul256.vim` Plugin.
	Ported and extended from original configurations in legacy vimscript.
]=]

return {
	'junegunn/seoul256.vim',
	lazy = false,
	priority = 1000,
	init = function()
		vim.g.seoul256_background = 234
		vim.cmd.colorscheme 'seoul256'
		vim.cmd [[
			highlight EndOfBuffer guifg=bg   | " Hide Buffer End Tildes for GUI
			highlight EndOfBuffer ctermfg=bg | " Hide Buffer End Tildes for Terminal
		]]
	end
}
