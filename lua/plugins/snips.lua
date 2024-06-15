--[=[
	SNIPS.lua:
	Configurations for snippet plugins such as the `SirVer/ultisnips` Plugin.
]=]

return {
	{
		'SirVer/ultisnips',
		enabled = false,
		ft = "tex", -- Snippets are currently only impelemted for TeX files
		config = function()
			vim.g.UltiSnipsExpandTrigger = "<tab>"
			vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
			vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
			vim.g.UltiSnipsSnippetDirectories = { vim.fn.stdpath('config') .. "/UltiSnips" }
			vim.g.UltiSnipsEditSplit = "vertical"
		end
	},
	{
		"L3MON4D3/LuaSnip", -- snippet engine using Lua
		version = "*"
	}
}
