return {
  {
    'saghen/blink.cmp',
    enabled = true,
    build = 'cargo build --release',
    event = 'InsertEnter',
    dependencies = {
      'saghen/blink.compat',
    },
    ---@module 'blink-cmp'
    ---@type blink.cmp.Config
    opts = {
      appearance = {
        use_nvim_cmp_as_default = true,
      },
      completion = {
        list = {
          selection = { preselect = false, auto_insert = true },
        },
        menu = { border = 'none' },
        accept = { auto_brackets = { enabled = false } },
        documentation = { auto_show = true, auto_show_delay_ms = 100, window = { border = 'none' } },
      },
      signature = {
        enabled = true,
        trigger = {
          show_on_insert = true,
        },
        window = {
          border = 'none',
          treesitter_highlighting = true,
          show_documentation = true,
        },
      },
      keymap = {
        preset = 'none',
        -- tab for snippet
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },

        -- completion window
        ['<C-n>'] = { 'show', 'show_documentation', 'fallback' },
        ['<C-e>'] = { 'hide', 'hide_documentation' },

        -- accept
        ['<CR>'] = { 'select_and_accept', 'fallback' },

        -- documentation
        ['<A-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<A-f>'] = { 'scroll_documentation_down', 'fallback' },
      },
      sources = {
        default = { inherit_defaults = true, 'laravel' },
        per_filetype = {
          lua = { inherit_defaults = true, 'lazydev' },
        },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
          laravel = {
            name = 'laravel',
            module = 'blink.compat.source',
            score_offset = 95, -- show at a higher priority than lsp
          },
        },
      },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    enabled = false, -- enabled this since i have issue with blink.cmp cursor with autocommands from ../core/autocmds.lua
    event = { 'InsertEnter', 'CmdLineEnter' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
    },
    config = function()
      local cmp = require 'cmp'
      local lsnip = require 'luasnip'

      local kind_icons = {
        Text = '  ',
        Method = '  ',
        Function = '  ',
        Constructor = '  ',
        Field = '  ',
        Variable = '  ',
        Class = '  ',
        Interface = '  ',
        Module = '  ',
        Property = '  ',
        Unit = '  ',
        Value = '  ',
        Enum = '  ',
        Keyword = '  ',
        Snippet = '  ',
        Color = '  ',
        File = '  ',
        Reference = '  ',
        Folder = '  ',
        EnumMember = '  ',
        Constant = '  ',
        Struct = '  ',
        Event = '  ',
        Operator = '  ',
        TypeParameter = '  ',
      }

      local has_words_before = function()
        ---@diagnostic disable-next-line: deprecated
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
      end

      cmp.setup {
        snippet = {
          expand = function(args)
            lsnip.lsp_expand(args.body)
          end,
        },
        formatting = {
          fields = { 'abbr', 'kind', 'menu' },
          format = function(_, vim_item)
            local kind = vim_item.kind
            local icons = string.format('%s%s', kind_icons[kind], kind)
            vim_item.kind = (icons or '?')
            vim_item.abbr = string.sub(vim_item.abbr, 1, 25)
            return vim_item
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<Tab>'] = function(fallback)
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
          ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif lsnip.jumpable(-1) then
              lsnip.jump(-1)
            else
              fallback()
            end
          end,
        },
        experiental = {
          ghost_text = true,
        },
        sources = cmp.config.sources({
          { name = 'lazydev', group_index = 0 },
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'nvim_lua' },
        }, { { name = 'buffer' } }),
      }
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    dependencies = {
      -- 'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local ls = require 'luasnip'

      require('luasnip.loaders.from_vscode').lazy_load()

      local parse = ls.parser.parse_snippet
      local types = require 'luasnip.util.types'

      ls.config.setup {
        history = true,
        updateevents = 'TextChanged,TextChangedI',
        enable_autosnippets = true,
        ext_base_prio = 300,
        ext_prio_increase = 2,
        ship_env = {
          types = types,
          parse = parse,
        },
      }

      local snippet = ls.snippet

      ls.add_snippets('html', {
        snippet('eruda', {
          ls.text_node {
            '<script src="//cdn.jsdelivr.net/npm/eruda"></script>',
            '<script>eruda.init()</script>',
          },
        }),
      })
    end,
  },
  {
    'echasnovski/mini.completion',
    enabled = false, -- enabled this since i have issue with blink.cmp cursor with autocommands from ../core/autocmds.lua
    event = 'VeryLazy',
    opts = {},
  },
}
