return {
  {
    'echasnovski/mini.surround',
    event = 'BufRead',
    opts = {
      mappings = {
        add = 'gza', -- Add surrounding in Normal and Visual modes
        delete = 'gzd', -- Delete surrounding
        find = 'gzf', -- Find surrounding (to the right)
        find_left = 'gzF', -- Find surrounding (to the left)
        highlight = 'gzh', -- Highlight surrounding
        replace = 'gzr', -- Replace surrounding
        update_n_lines = 'gzn', -- Update `n_lines`

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
    },
  },
  -- { 'echasnovski/mini.ai', event = 'BufReadPost', version = false, opts = {} },
  {
    'alex-popov-tech/store.nvim',
    cmd = 'Store',
    keys = {
      { '<leader>s', '<cmd>Store<cr>', desc = 'Open Plugin Store' },
    },
    opts = {
      -- optional configuration here
    },
  },
  {
    'olimorris/persisted.nvim',
    event = 'BufReadPre', -- Ensure the plugin loads only when a buffer has been loaded
    ---@module 'persisted'
    opts = {
      autoload = true,
      autosave = true,
      use_git_branching = true,
      -- Your config goes here ...
    },
    config = function(_, opts)
      require('persisted').setup(opts)
      local util = require 'core.util'

      vim.api.nvim_create_autocmd('User', {
        pattern = 'PersistedSavePre',
        callback = function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if util.filetypes.should_ignore(buf) then
              vim.api.nvim_buf_delete(buf, { force = true })
            end
          end
        end,
      })
    end,
  },
}
