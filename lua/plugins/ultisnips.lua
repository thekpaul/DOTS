--[=[
	PLUGINS_ULTISNIPS.lua:
	Configurations for the `SirVer/ultisnips` Plugin.
	Ported and extended from original configurations in legacy vimscript.
]=]

vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
vim.g.UltiSnipsSnippetDirectories = { vim.fn.stdpath('config') .. "/UltiSnips" }
vim.g.UltiSnipsEditSplit = "vertical"