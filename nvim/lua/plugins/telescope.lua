--[=[
	PLUGINS_TELESCOPE.lua:
	Configurations for the `nvim-telescope/telescope.nvim` Plugin.
]=]

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons"
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					}
				}
			}
		})

		telescope.load_extension("fzf")

		local keymap = vim.keymap

		keymap.set("n", "<leader>ff", builtin.find_files,
			{ desc = "[F]uzzy find [f]iles in Neovim's PWD" }
		)
		keymap.set("n", "<leader>fg", builtin.git_files,
			{ desc = "[F]uzzy find files with [G]it" }
		)
		keymap.set("n", "<leader>fh", builtin.oldfiles,
			{ desc = "[F]uzzy find from files in [h]istory" }
		)
		keymap.set("n", "<leader>fs", builtin.live_grep,
			{ desc = "[F]ind [s]tring in Neovim's PWD" }
		)
		keymap.set("n", "<leader>fc", builtin.grep_string,
			{ desc = "[F]ind string under [c]ursor in PWD" }
		)
	end
}
