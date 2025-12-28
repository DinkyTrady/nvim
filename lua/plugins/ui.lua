return {
  {
    'echasnovski/mini.indentscope',
    event = 'BufRead',
    config = function()
      require('mini.indentscope').setup {
        symbol = '│',
        options = { try_as_border = true },
        draw = { animation = require('mini.indentscope').gen_animation.none() },
      }
    end,
  },
  {
    'echasnovski/mini.icons',
    version = false,
    event = 'VeryLazy',
    opts = {},
  },
  {
    'stevearc/oil.nvim',
    cmd = 'Oil',
    keys = {
      {
        mode = { 'n', 'v' },
        '-',
        function()
          require('oil').open()
        end,
        desc = 'Open Oil',
      },
    },
    opts = {
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
    },
  },
  {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
      user_default_options = {
        css = true,
        tailwind = true,
        -- mode = 'virtualtext',
        virtualtext_inline = false,
      },
    },
  },
}
