--[=[
	PLUGINS_MASON.lua:
	Configurations for the `williamboman/mason.nvim` Plugin, with dependencies.
]=]

return {
	{
		"williamboman/mason.nvim",
		version = "1.*",
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed   = "✓ ",
					package_pending     = "➜ ",
					package_uninstalled = "✗ "
				}
			}
		}
	},
	{
		"williamboman/mason-lspconfig.nvim",
		version = "1.*",
		dependencies = {
			"williamboman/mason.nvim" -- Loaded before!
		},
		opts = {
			ensure_installed = {
				"lua_ls",
				"clangd"
			},
			automatic_installation = true
		}
	}
}
