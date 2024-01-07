return {
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		config = function()
			vim.cmd("LspStart")

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem = {
				snippetSupport = true,
				resolveSupport = {
					properties = {
						"documentation",
						"detail",
						"additionalTextEdits",
					},
				},
			}

			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			local on_attach = function(client, bufnr)
				if client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_augroup("lsp_document_highlight", {
						clear = false,
					})
					vim.api.nvim_clear_autocmds({
						buffer = bufnr,
						group = "lsp_document_highlight",
					})
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						group = "lsp_document_highlight",
						buffer = bufnr,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						group = "lsp_document_highlight",
						buffer = bufnr,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end

			local lsp = require("lspconfig")
			local servers = { "tsserver", "eslint", "jsonls", "emmet_ls", "html", "cssls" }

			for _, server in ipairs(servers) do
				lsp[server].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end

			lsp.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
								[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
							},
							maxPreload = 100000,
							preloadFileSize = 10000,
						},
					},
				},
			})

			require("config.lsp-settings")
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		event = "BufReadPre",
		config = function()
			local nls = require("null-ls")

			nls.setup({
				sources = {
					nls.builtins.formatting.stylua,
					nls.builtins.formatting.prettier,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({
							group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
							buffer = bufnr,
						})
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
							buffer = bufnr,
							callback = function()
								-- on 0.7, use vim.lsp.buf.formatting_sync() instead
								vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 1500 })
							end,
						})
					end
				end,
			})
		end,
	},
}
