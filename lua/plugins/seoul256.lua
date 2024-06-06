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

		-- Show comments as ITALIC (works well with cursive fonts)
		--   -> Apply AFTER Colorscheme!
		local oldComment = vim.api.nvim_get_hl(0, { name = "Comment" })
		local newComment = vim.tbl_extend('force',
			{}, -- Baseline empty table to fill necessary key-value pairs
			oldComment, -- Get all pairs from original `Comment` group
			{ italic = true } -- Overwrite as italics
		)

		vim.api.nvim_set_hl(0, "Comment", newComment)
	end
}
