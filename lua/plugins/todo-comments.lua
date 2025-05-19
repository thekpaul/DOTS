return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = { "TodoTelescope", "TodoQuickFix" },
	opts = {
		keywords = {
			FIX = {
				icon = " ",
				color = "error",
				alt = { "FIXME", "BUG", "ERR", "ERROR", "ISSUE" }
			},
			TODO = {
				icon = " ",
				color = "hint",
				alt = { "DO" }
			},
			HACK = {
				icon = " ",
				color = "warning"
			},
			WARN = {
				icon = " ",
				color = "warning",
				alt = { "WARNING" }
			},
			PERF = {
				icon = " ",
				color = "perf",
				alt = { "OPT", "PERFORMANCE", "OPTIMIZE" }
			},
			NOTE = {
				icon = " ",
				color = "info",
				alt = { "INFO" }
			},
			TEST = {
				icon = "⏲ ",
				color = "test",
				alt = { "TESTING", "PASSED", "FAILED" }
			}
		},
		colors = {
			perf = { "DiagnosticOk", "#B3F6C0" }
		}
	},
	keys = {
		{
			"<leader>tn", function ()
				require("todo-comments").jump_next()
			end, desc = "Next todo comment"
		},
		{
			"<leader>tp", function ()
				require("todo-comments").jump_prev()
			end, desc = "Previous todo comment"
		},
		{
			"<leader>ft", '<CMD>TodoTelescope<CR>',
			desc = "[F]ind [T]odo Comments (from todo-comments.nvim)"
		}
	}
}
