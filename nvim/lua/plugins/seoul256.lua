--[=[
	PLUGINS_SEOUL256.lua:
	Configurations for the `junegunn/seoul256.vim` Plugin.
	Ported and extended from original configurations in legacy vimscript.
]=]

return {
	'junegunn/seoul256.vim',
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.seoul256_background = 234
		vim.cmd.colorscheme 'seoul256'

		-- Hide buffer end tildes
		local DefNormal = vim.api.nvim_get_hl(0, { name = "Normal" })
		vim.api.nvim_set_hl(0, "EndOfBuffer", {
			-- NOTE: Only values from STARTUP are applied!
			fg      = DefNormal.bg,     -- Hide in GUI
			ctermfg = DefNormal.ctermbg -- Hide in TUI
		})
	end
}
