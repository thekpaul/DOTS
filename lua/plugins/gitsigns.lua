--[=[
	GITSIGNS.lua:
	Configurations for the `lewis6991/gitsigns.nvim` Plugin.
]=]

return {
	'lewis6991/gitsigns.nvim',
	opts = {
		on_attach = function(bufnr)
			local gitsigns = require('gitsigns')

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Baseline Table for Options
			local opts = { buffer = bufnr, --[[silent = true]] }

			-- Navigation
			opts.desc = "Move Cursor to [N]ext Git Change"
			map('n', '<leader>gn', function()
				if vim.wo.diff then
					vim.cmd.normal({'<leader>gc', bang = true})
				else
					gitsigns.nav_hunk('next')
				end
			end, opts)

			opts.desc = "Move Cursor to [P]revious Git Change"
			map('n', '<leader>gp', function()
				if vim.wo.diff then
					vim.cmd.normal({'<leader>gC', bang = true})
				else
					gitsigns.nav_hunk('prev')
				end
			end, opts)

			-- Actions
			opts.desc = "[S]tage Hunk at Current Cursor Position"
			map('n', '<leader>gs', gitsigns.stage_hunk, opts)

			opts.desc = "[R]eset Hunk at Current Cursor Position"
			map('n', '<leader>gr', gitsigns.reset_hunk, opts)

			opts.desc = "[S]tage Hunk in Selected Lines"
			map('v', '<leader>gs', function()
				gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')}
			end, opts)

			opts.desc = "[R]eset Hunk in Selected Lines"
			map('v', '<leader>gr', function()
				gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')}
			end, opts)

			opts.desc = "[S]tage ALL Hunks in Current Buffer"
			map('n', '<leader>gS', gitsigns.stage_buffer, opts)

			opts.desc = "[U]ndo LAST CALL of Stage Hunk"
			map('n', '<leader>gu', gitsigns.undo_stage_hunk, opts)

			opts.desc = "[R]eset ALL Hunk Lines in Buffer"
			map('n', '<leader>gR', gitsigns.reset_buffer, opts)

			opts.desc = "Pre[v]iew Hunk at Current Cursor Position (Floating)"
			map('n', '<leader>gv', gitsigns.preview_hunk, opts)

			opts.desc = "Show Current Line `git [b]lame` Results (Floating)"
			map('n', '<leader>gb', function()
				gitsigns.blame_line{ full = true }
			end, opts)

			opts.desc = "[T]oggle Current Line [B]lame"
			map('n', '<leader>gtb', gitsigns.toggle_current_line_blame, opts)

			opts.desc = "Open VIM[D]IFF for Current Buffer Against INDEX"
			map('n', '<leader>gd', gitsigns.diffthis, opts)

			opts.desc = "Open VIM[D]IFF for Current Buffer Against HEAD"
			map('n', '<leader>gD', function()
				gitsigns.diffthis('~')
			end, opts)

			opts.desc = "[T]oggle View Modifications and [D]eletions"
			map('n', '<leader>gtd', gitsigns.toggle_deleted, opts)

			opts.desc = "Select Hunk at Current Cursor"
			map({'o', 'x'}, 'ih', gitsigns.select_hunk, opts)
		end
	}
}
