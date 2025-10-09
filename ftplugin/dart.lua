require('lazyload').lazy_load {
  {
  src = 'https://github.com/nvim-lua/plenary.nvim',
  data = {
    lazy = false
  }
  },
  {
    src = 'https://github.com/nvim-flutter/flutter-tools.nvim',
    data = {
      lazy = false,
      config = function()
        require('flutter-tools').setup {
          -- fvm = true,
          lsp = {
            on_attach = require('lsp-settings').on_attach,
          },
        }
      end,
    },
  },
}
