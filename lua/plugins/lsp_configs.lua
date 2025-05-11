--[=[
	PLUGINS_LSP-CONFIGS.lua:
	Configurations for various LSP Plugins such as `neovim/nvim-lspconfig`.
]=]

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"nvim-telescope/telescope.nvim"
	},
	config = function()
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
				map.set("n", "<leader>lp", function ()
					vim.diagnostic.jump({ count = -1, float = true })
				end, opts)

				opts.desc = "Go to [N]ext Diagnostic"
				map.set("n", "<leader>ln", function ()
					vim.diagnostic.jump({ count = 1, float = true })
				end, opts)

				opts.desc = "Explicitly [R]e[s]tart LSP"
				map.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
			end
		})

		-- Enable Autocompletion (Assign to EVERY LSP Server Configuration)
		local capabilities = cmp_nvim_lsp.default_capabilities()
		vim.lsp.config('*', { capabilities = capabilities })

		-- Diagnostic symbols in sign column (gutter)
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN]  = " ",
					[vim.diagnostic.severity.HINT]  = "󰠠 ",
					[vim.diagnostic.severity.INFO]  = " "
				},
				texthl = {
					[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
					[vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
					[vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
					[vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo"
				}
			}
		})

		-- Lua LSP `lua_ls`: Managed via Mason.nvim
		vim.lsp.config('lua_ls', {
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if path ~= vim.fn.stdpath('config') and (
						vim.uv.fs_stat(path .. '/.luarc.json') or
						vim.uv.fs_stat(path .. '/.luarc.jsonc')
					) then
						return
					end
				end

				client.config.settings.Lua = vim.tbl_deep_extend(
					'force', client.config.settings.Lua, {
						runtime = {
							version = 'LuaJIT',
							path = { 'lua/?.lua', 'lua/?/init.lua', },
						},
						workspace = {
							checkThirdParty = false,
							library = { vim.env.VIMRUNTIME, '${3rd}/luv/library' }
						}
					}
				)
			end,
			settings = {
				Lua = {}
			}
		})

		-- (System)Verilog LSP `verible`: Managed via Mason.nvim
		vim.lsp.config('verible', {
			cmd = { 'verible-verilog-ls', '--rules_config_search' },
			root_dir = function(fname)
				return
					vim.fs.dirname(vim.fs.find(
						'.rules.verible_lint', -- local Verible lint rule
						{ path = fname, upward = true }
					)[1]) or
					vim.fs.dirname(vim.fs.find(
						'.git', -- local Git repository, second option
						{ path = fname, upward = true }
					)[1]) or
					vim.fn.getcwd() -- current directory (for single-file system), fallback
			end
		})

		-- Nushell LSP: binary built-in
		-- Note that the Nushell binary must be installed on system and
		-- able to be found by Neovim for the Nushell LSP to function correctly.
		vim.lsp.enable('nushell')
	end
}
