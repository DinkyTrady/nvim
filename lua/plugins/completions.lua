return {
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdLineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
		},
		config = function()
			local cmp = require("cmp")
			local lsnip = require("luasnip")

			local kind_icons = {
				Text = "  ",
				Method = "  ",
				Function = "  ",
				Constructor = "  ",
				Field = "  ",
				Variable = "  ",
				Class = "  ",
				Interface = "  ",
				Module = "  ",
				Property = "  ",
				Unit = "  ",
				Value = "  ",
				Enum = "  ",
				Keyword = "  ",
				Snippet = "  ",
				Color = "  ",
				File = "  ",
				Reference = "  ",
				Folder = "  ",
				EnumMember = "  ",
				Constant = "  ",
				Struct = "  ",
				Event = "  ",
				Operator = "  ",
				TypeParameter = "  ",
			}

			local has_words_before = function()
				---@diagnostic disable-next-line: deprecated
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup({
				snippet = {
					expand = function(args)
						lsnip.lsp_expand(args.body)
					end,
				},
				formatting = {
					fields = { "abbr", "kind", "menu" },
					format = function(_, vim_item)
						local kind = vim_item.kind
						local icons = string.format("%s%s", kind_icons[kind], kind)
						vim_item.kind = (icons or "?")
						vim_item.abbr = string.sub(vim_item.abbr, 1, 25)
						return vim_item
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif lsnip.expand_or_jumpable() then
							lsnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end,
					["<S-Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif lsnip.jumpable(-1) then
							lsnip.jump(-1)
						else
							fallback()
						end
					end,
				}),
				experiental = {
					ghost_text = true,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "nvim_lua" },
				}, { { name = "buffer" } }),
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local ls = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()

			local parse = ls.parser.parse_snippet
			local types = require("luasnip.util.types")

			ls.config.setup({
				history = true,
				updateevents = "TextChanged,TextChangedI",
				enable_autosnippets = true,
				ext_base_prio = 300,
				ext_prio_increase = 2,
				ship_env = {
					types = types,
					parse = parse,
				},
			})

			local snippet = ls.snippet

			ls.add_snippets("html", {
				snippet("eruda", {
					ls.text_node({
						'<script src="//cdn.jsdelivr.net/npm/eruda"></script>',
						"<script>eruda.init()</script>",
					}),
				}),
			})
		end,
	},
}
