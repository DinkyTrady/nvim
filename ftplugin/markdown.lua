require('lazyload').lazy_load {
  {
    src = 'https://github.com/OXY2DEV/markview.nvim',
    data = {
      lazy = false,
      config = function ()
        require'markview'.setup()
      end
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
