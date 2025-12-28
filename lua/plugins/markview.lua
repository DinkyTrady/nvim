return {
  'OXY2DEV/markview.nvim',
  event = 'VeryLazy',
  -- ft = { 'markdown', 'codecompanion' },
  opts = {
    preview = {
      icon_provider = 'mini',
      filetypes = {
        'markdown',
        'markdown_inline',
        'codecompanion',
      },
      ignore_buftypes = {},
    },
  },
}
