--[=[
	PLUGINS_NVIM-CMP.lua:
	Configurations for the `hrsh7th/nvim-cmp` Plugin.
]=]

return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",          -- source for text in buffer
		"hrsh7th/cmp-path",            -- source for file system paths
		"L3MON4D3/LuaSnip",            -- snippet engine using Lua
		"saadparwaiz1/cmp_luasnip",    -- for autocompletion
		"rafamadriz/friendly-snippets" -- useful snippets (VS Code format)
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		-- load VS Code style snippets from installed plugins
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = { -- Completion Menu -> `:h completeopt`
				completeopt = "menu, menuone, preview, noselect"
			},
			snippet = { -- Interaction with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end
			},
			mapping = cmp.mapping.preset.insert({
				["<S-Tab>"]   = cmp.mapping.select_prev_item(),
				["<Tab>"]     = cmp.mapping.select_next_item(),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-c>"]     = cmp.mapping.abort(),
				["<CR>"]      = cmp.mapping.confirm({ select = false })
			}),
			sources = cmp.config.sources({
				-- Order here is respected
				{ name = "nvim_lsp" }, -- LSP recommendations
				{ name = "luasnip" },  -- snippets
				{ name = "buffer" },   -- current buffer text
				{ name = "path" }      -- filesystem paths
			})
		})
	end
}
