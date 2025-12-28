--- Helper for git
return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>gd', '<Cmd>Gitsigns diffthis<Cr>', 'Diff current buffer' },
      { '<leader>gb', '<Cmd>Gitsigns blame_line<Cr>', 'Blame current line' },
      { '<leader>gB', '<Cmd>Gitsigns blame<Cr>', 'Blame current line' },
    },
    opts = {
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 250,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    },
  },
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
  },
}
