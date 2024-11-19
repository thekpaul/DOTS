--[=[
	PLUGINS_TELESCOPE.lua:
	Configurations for the `nvim-telescope/telescope.nvim` Plugin.
]=]

return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim", -- Separate Specs Below
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
						},
						n = {
							["dd"] = require("telescope.actions").delete_buffer,
							["q"] = require("telescope.actions").close
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
			keymap.set("n", "<leader>fb", function()
					builtin.buffers({
						sort_mru = true,
						sort_lastused = true,
						initial_mode = "normal"
					})
				end,
				{ desc = "[F]ind [b]uffer in current Neovim session" }
			)
		end
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = function(plugin)
			local throw_err = function(cmd)
				if cmd.code ~= 0 then error(cmd.stderr) end
			end
			if vim.uv.os_uname().sysname == "Windows_NT" then
				local cmd = vim.system({
					'cmake', '-S.', '-Bbuild', '-DCMAKE_BUILD_TYPE=Release',
					'-G', 'Visual Studio 17 2022'
				}, { cwd = plugin.dir }):wait()
				if cmd.code ~= 0 then
					cmd = vim.system({
						-- Use shell-agnostic `git` to clear failed build output
						'git', 'clean', '-Xfd'
					}, { cwd = plugin.dir }):wait()
					if cmd.code ~= 0 then
						error(cmd.stderr .. "\
							Failed to clean previous build from Visual Studio.")
					end
					cmd = vim.system({
						'cmake', '-S.', '-Bbuild', '-DCMAKE_BUILD_TYPE=Release',
						'-G', 'MinGW Makefiles'
					}, { cwd = plugin.dir }):wait()
					if cmd.code ~= 0 then
						error(cmd.stderr .. "\
							CMake cannot find a usable generator.\
							Please install either Visual Studio 2022 or MinGW.")
					end
				end
				cmd = vim.system({
					'cmake', '--build', 'build', '--config', 'Release'
				}, { cwd = plugin.dir }):wait()
				throw_err(cmd)
				cmd = vim.system({
					'cmake', '--install', 'build', '--prefix', 'build'
				}, { cwd = plugin.dir }):wait()
				throw_err(cmd)
			else
				local cmd = vim.system({ 'make' }, { cwd = plugin.dir }):wait()
				throw_err(cmd)
			end
		end
	}
}
