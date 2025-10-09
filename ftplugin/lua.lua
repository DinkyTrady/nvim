require('lazyload').lazy_load {
  {
    src = 'https://github.com/folke/lazydev.nvim',
    data = {
      lazy = false,
      config = function()
        require('lazydev').setup {
          library = {
            -- made luv library not avaiable only when type vim.uv it will need to
            -- load lsp again to get the library
            { path = '${3rd}/luv/library' },
            vim.fn.stdpath 'data' .. '/lazy/snacks.nvim',
          },
        }
      end,
    },
  },
  {
    src = 'https://github.com/saghen/blink.cmp',
    data = {
      event = 'InsertEnter',
      config = function()
        require('blink.cmp').setup {
          sources = {
            per_filetype = {
              lua = { inherit_defaults = true, 'lazydev' },
            },
            providers = {
              lazydev = {
                name = 'LazyDev',
                module = 'lazydev.integrations.blink',
                score_offset = 100,
              },
            },
          },
        }
      end,
    },
  },
}
