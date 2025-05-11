--[=[
	PLUGINS_MASON.lua:
	Configurations for the `williamboman/mason.nvim` Plugin, with dependencies.
]=]

local function version()
	if vim.version.lt(vim.version(), '0.11.0') then
		return "1.*"
	else
		return "2.*"
	end
end

return {
	{
		"williamboman/mason.nvim",
		version = version(),
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
		version = version(),
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
