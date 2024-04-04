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
		-- Source: https://www.reddit.com/r/neovim/comments/yexeil/comment/iu0lbgt/?snippet=1_48_242
		local DefNormal = vim.api.nvim_get_hl(0, { name = "Normal" }) -- `Normal` highlight group
		local HideTilde = vim.tbl_extend('force', -- Overwrite from right-most table
			{}, -- Baseline empty table to fill necessary key-value pairs
			DefNormal, -- Get all pairs from `Normal` (keep backgrounds)
			{ fg = DefNormal.bg, ctermfg = DefNormal.ctermbg } -- Overwrite foregrounds
		)
		vim.api.nvim_set_hl(0, "EndOfBuffer", HideTilde)
	end
}
