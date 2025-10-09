require('lazyload').lazy_load {
  {
    src = 'https://github.com/chomosuke/typst-preview.nvim',
    version = '1.*',
    data = {
      lazy = false,
      config = function()
        require('typst-preview').setup {}
      end,
    },
  },
  {
    src = 'https://github.com/OXY2DEV/markview.nvim',
    data = {
      lazy = false,
      config = function()
        require('markview').setup {
          typst = {
            enable = true,
          },
        }
      end,
    },
  },
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    data = {
      lazy = false,
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup {
          highlight = { enable = true },
        }
      end,
    },
  },
}
