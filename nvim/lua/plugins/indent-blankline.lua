--[=[
	INDENT-BLANKLIKE.lua:
	Configurations for the `lukas-reineke/indent-blankline.nvim` Plugin.
]=]

return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
	 --	debounce = 100,
		indent = {
			char = "▏",
			tab_char = "▏",
			highlight = { "NonText" }
		},
		whitespace = {
			remove_blankline_trail = false,
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
	}
}
