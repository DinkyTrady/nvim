local util = require 'core.util'

local va = vim.api
local autocmd = vim.api.nvim_create_autocmd
local cmd = vim.cmd

autocmd('BufReadPost', {
  callback = function(args)
    if util.filetypes.should_ignore(args.buf) then
      return
    end

    vim.schedule(function()
      local last_pos = va.nvim_buf_get_mark(args.buf, '"')

      if
        last_pos
        and last_pos[1] > 0
        and last_pos[2] >= 0
        and va.nvim_buf_line_count(args.buf)
      then
        va.nvim_win_set_cursor(0, { last_pos[1], last_pos[2] })
      end
    end)
  end,
})

autocmd('VimResized', {
  callback = function()
    cmd 'wincmd='
  end,
})

autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank { higroup = 'Visual', timeout = 100 }
  end,
})

vim.api.nvim_create_user_command('LspOn', function()
  local clients = vim.lsp.get_clients()
  local lsp_name = vim.tbl_map(function(client)
    return client.name
  end, clients)
  vim.notify(vim.inspect(lsp_name), vim.log.levels.INFO, { title = 'List Active LSP client', timeout = 5000 })
end, { desc = 'Get active lsp server' })
