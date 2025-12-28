return {
  'my-ui',
  dir = vim.fn.stdpath 'config' .. '/lua/ui',
  dev = true,
  event = 'VeryLazy',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'echasnovski/mini.icons',
  },
  config = function()
    -- require 'ui.statuscolumn'
    require 'ui.statusline'
  end,
}
