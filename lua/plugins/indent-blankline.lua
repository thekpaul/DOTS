--[=[
	INDENT-BLANKLIKE.lua:
	Configurations for the `lukas-reineke/indent-blankline.nvim` Plugin.
]=]

return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		-- Indentation whitespace highlight groups
		vim.api.nvim_set_hl(0, "IndentOdd",  { -- Odd  level
			ctermbg = 233, bg = "#181818"
		})
		vim.api.nvim_set_hl(0, "IndentEven", { -- Even level
			ctermbg = 235, bg = "#303030"
		})

		require("ibl").setup({
		 --	debounce = 100,
			indent = {
				char = "▏",
				tab_char = "▏",
				highlight = { "NonText" }
			},
			whitespace = {
				remove_blankline_trail = false,
				highlight = { "IndentOdd", "IndentEven" }
			},
		 --	scope = {
		 --		<++>
		 --	},
		 --	exclude = {
		 --		<++>
		 --	},
		 --	viewport_buffer = {
		 --		<++>
		 --	}
		})
	end
}
