local util = require 'core.util'

-- Builtin undotree
vim.cmd('packadd nvim.undotree')

require('lazyload').lazy_load {
  {
    src = 'https://github.com/folke/snacks.nvim',
    data = {
      -- lazy = false,
      event = 'UIEnter',
      -- stylua: ignore
      keys = {
        { 'n',          ';f',         function() Snacks.picker.files { hidden = true } end,                                                'Find Files' },
        { 'n',          ';w',         function() Snacks.picker.grep() end,                                                                 'Find Words (cwd)' },
        { 'n',          ';f',         function() Snacks.picker.files { hidden = true } end,                                                'Find Files' },
        { 'n',          ';F',         function() Snacks.picker.files { hidden = true, ignored = true, cwd = util.get_project_root() } end, 'Find Files (cwd)' },
        { 'n',          ';r',         function() Snacks.picker.recent { cwd = util.get_project_root() } end,                               'Find Recent Files' },
        { 'n',          ';b',         function() Snacks.picker.buffers { current = false } end,                                            'Find Buffers' },
        { 'n',          ';h',         function() Snacks.picker.help() end,                                                                 'Help pages' },
        { 'n',          ';m',         function() Snacks.picker.keymaps() end,                                                              'Find Keymaps' },
        { 'n',          '<leader>z',  function() Snacks.picker.zoxide() end,                                                               'Change directory with zoxide' },
        { 'n',          ';c',         function() Snacks.picker.files { hidden = true, ignored = true, cwd = vim.fn.stdpath 'config' } end, 'Opening config' },
        { 'n',          ';C',         function() Snacks.picker.files { hidden = true, ignored = true, cwd = '~/personal/dotsfiles' } end,  'Opening config' },
        { 'n',          '<leader>gg', function() Snacks.lazygit() end,                                                                     'Open LazyGit' },
        { { 'n', 't' }, '<C-/>',      function() Snacks.terminal() end,                                                                    'Open Terminal' },
      },
      config = function()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'OilActionsPost',
          callback = function(args)
            if args.data.actions.type == 'move' then
              Snacks.rename.on_rename_file(
                args.data.actions.src_url,
                args.data.actions.dest_url
              )
            end
          end,
        })

        --- source code from https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md
        vim.api.nvim_create_autocmd('LspProgress', {
          callback = function(args)
            local spinner = {
              '⠋',
              '⠙',
              '⠹',
              '⠸',
              '⠼',
              '⠴',
              '⠦',
              '⠧',
              '⠇',
              '⠏',
            }
            vim.notify(vim.lsp.status(), 'info', {
              id = 'lsp_progress',
              title = 'LSP Progress',
              opts = function(notif)
                notif.icon = args.data.params.value.kind == 'end' and ' '
                  or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
              end,
            })
          end,
        })

        require('snacks').setup {
          input = {},
          picker = {},
          image = {},
          notifier = {},
          notify = {},
          statuscolumn = {},
          quickfile = {},
        }
      end,
    },
  },
  {
    src = 'https://github.com/tpope/vim-fugitive',
    data = {
      -- lazy = false,
      event = 'BufReadPre',
    },
  },
  {
    src = 'https://github.com/lewis6991/gitsigns.nvim',
    data = {
      event = 'BufReadPre',
      config = function()
        require('gitsigns').setup {
          current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
          current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 250,
            ignore_whitespace = false,
            virt_text_priority = 100,
          },
          current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        }
      end,
    },
  },
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    data = {
      event = 'UIEnter',
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup {
          highlight = { enable = true },
        }
      end,
    },
  },
  {
    src = 'https://github.com/neovim/nvim-lspconfig',
    data = {
      event = 'BufReadPre',
    },
  },
  {
    src = 'https://github.com/echasnovski/mini.icons',
    data = {
      lazy = false,
      config = function()
        require('mini.icons').setup()
      end,
    },
  },
  {
    src = 'https://github.com/echasnovski/mini.surround',
    data = {
      event = 'BufReadPost',
      config = function()
        require('mini.surround').setup {}
      end,
    },
  },
  {
    src = 'https://github.com/stevearc/oil.nvim',
    data = {
      cmd = 'Oil',
      keys = { 'n', '-', 'Oil', 'Open Oil' },
      config = function()
        require('oil').setup {
          columns = {
            'size',
            'mtime',
            'icon',
          },

          keymaps = {
            -- disable
            ['<Cr>'] = '',
            ['<C-c>'] = '',
            ['<C-p>'] = '',

            -- change to other
            ['q'] = 'actions.close',
            ['gl'] = 'actions.select',
            ['gp'] = 'actions.preview',
          },
          view_options = {
            show_hidden = true,
          },
        }
      end,
    },
  },
  {
    src = 'https://github.com/mason-org/mason.nvim',
    data = {
      cmd = { 'Mason', 'MasonLog' },
      config = function()
        require('mason').setup {}
      end,
    },
  },
  {
    -- HACK: use commands `:BlinkCmp build` to build the fuzzy
    src = 'https://github.com/saghen/blink.cmp',
    data = {
      event = 'InsertEnter',
      config = function()
        require('blink.cmp').setup {
          appearance = {
            use_nvim_cmp_as_default = true,
          },
          completion = {
            menu = { border = 'none' },
            accept = { auto_brackets = { enabled = false } },
            documentation = {
              auto_show = true,
              auto_show_delay_ms = 100,
              window = { border = 'none' },
            },
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
        }
      end,
    },
  },
  {
    src = 'https://github.com/rafamadriz/friendly-snippets',
    data = {
      event = 'InsertEnter',
    },
  },
  {
    src = 'https://github.com/catgoose/nvim-colorizer.lua',
    data = {
      event = 'BufRead',
      config = function()
        require('colorizer').setup {
          user_default_options = {
            css = true,
            tailwind_opts = {
              update_names = 'both'
            }
          }
        }
      end,
    },
  },{
    src = 'https://github.com/nvim-lua/plenary.nvim',
    data = {
      lazy = false
    }
  },
  {
    src = 'https://github.com/olimorris/codecompanion.nvim',
    data = {
      event = 'BufRead',
      config = function ()
        require("codecompanion").setup {}
      end
    }
  },
}
