--[=[
	PLUGINS_LSP-CONFIGS.lua:
	Configurations for various LSP Plugins such as `neovim/nvim-lspconfig`.
]=]

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"nvim-telescope/telescope.nvim"
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local tele_builtin = require("telescope.builtin")
		local map = vim.keymap

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings: See `:h vim.lsp.*` for docs
				local opts = { buffer = ev.buf, silent = true }

				-- Override Global Keymaps for Similar Functionalities {
				opts.desc = "Show LSP [D]efinitions with Telescope"
				map.set("n", "gd", tele_builtin.lsp_definitions, opts)

				opts.desc = "[G]o to [D]eclaration"
				map.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show Documentation for What is Under Cursor [K]"
				map.set("n", "K", vim.lsp.buf.hover, opts)
				-- }

				-- Telescope Integrations (Lower-cases for All Mappings) {
				opts.desc = "Show LSP [R]eferences with Telescope"
				map.set("n", "<leader>lr", tele_builtin.lsp_references, opts)

				opts.desc = "Show LSP [I]mplementations with Telescope"
				map.set("n", "<leader>li", tele_builtin.lsp_implementations, opts)

				opts.desc = "Show LSP [T]ype Definitions"
				map.set("n", "<leader>lt", tele_builtin.lsp_type_definitions, opts)

				opts.desc = "Show Current [B]uffer Diagnostics"
				map.set("n", "<leader>lB", function()
					tele_builtin.diagnostics({ bufnr = 0 })
				end, opts)
				-- }

				opts.desc = "See Available Code [A]ctions"
				map.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart [R]e[n]ame"
				map.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show [L]ine Diagnostics"
				map.set("n", "<leader>ll", vim.diagnostic.open_float, opts)

				opts.desc = "Go to [P]revious Diagnostic"
				map.set("n", "<leader>lp", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to [N]ext Diagnostic"
				map.set("n", "<leader>ln", vim.diagnostic.goto_next, opts)

				opts.desc = "Explicitly [R]e[s]tart LSP"
				map.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
			end
		})

		-- Enable Autocompletion (Assign to EVERY LSP Server Configuration)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Diagnostic symbols in sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Handlers used in `mason-lspconfig.nvim` to set up LSP servers
		-- See `:h mason-lspconfig.setup_handlers()` for docs
		mason_lspconfig.setup_handlers({
			-- First entry as the default, fallback handler
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities
				})
			end,
			["lua_ls"] = function() -- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					-- Provided by `lua_ls` documentation for primary use in Neovim
					on_init = function(client)
						if client.workspace_folders then
							local path = client.workspace_folders[1].name
							if vim.uv.fs_stat(path..'/.luarc.json')
								or vim.uv.fs_stat(path..'/.luarc.jsonc') then
								return
							end
						end

						client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
							runtime = {
								-- Tell the language server which version of Lua you're using
								-- (most likely LuaJIT in the case of Neovim)
								version = 'LuaJIT'
							},
							-- Make the server aware of Neovim runtime files
							workspace = {
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME
									-- Depending on the usage, you might want to add additional paths here.
									-- "${3rd}/luv/library"
									-- "${3rd}/busted/library",
								}
								-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
								-- library = vim.api.nvim_get_runtime_file("", true)
							}
						})
					end,
					settings = {
						Lua = { -- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" }
							},
							completion = {
								callSnippet = "Replace"
							}
						}
					}
				})
			end,
			["cmake"] = function()
				lspconfig["cmake"].setup({
					capabilities = capabilities
				})
			end--[==[,
			["clangd"] = function()
				lspconfig["clangd"].setup({
					capabilities = capabilities
				})
			end
			--]==]
		})

	end
}
