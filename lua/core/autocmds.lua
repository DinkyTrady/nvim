local util = require 'core.util'
local va, cmd = vim.api, vim.cmd

local autocmd = va.nvim_create_autocmd
---@param name string the name of the augroup
---@param clear boolean it should be clear or not
local augroup = function(name, clear)
  va.nvim_create_augroup(name, { clear = clear })
end

autocmd('FileType', {
  pattern = vim.tbl_keys(util.filetypes.ignore),
  callback = function()
    va.nvim_set_option_value('statuscolumn', ' %l ', { win = va.nvim_get_current_win(), scope = 'local' })
  end,
})

autocmd('BufReadPost', {
  callback = function(args)
    if util.filetypes.should_ignore(args.buf) then
      return
    end

    vim.schedule(function()
      local last_pos = va.nvim_buf_get_mark(args.buf, '"')

      if last_pos and last_pos[1] > 0 and last_pos[2] >= 0 and va.nvim_buf_line_count(args.buf) then
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

-- Diagnostic Changed
autocmd('DiagnosticChanged', {
  callback = function()
    vim.schedule(function()
      cmd 'redrawstatus'
      -- not used for now since still experimental
      -- va.nvim__redraw { statusline = true }
    end)
  end,
})

local group_redraw_cmdline = augroup('CmdlineLineNr', true)

autocmd('CmdLineEnter', {
  group = group_redraw_cmdline,
  callback = function()
    -- vim.o.cmdheight = 1
    if vim.o.number then
      vim.o.relativenumber = false
      va.nvim__redraw { statuscolumn = true }
    end
  end,
})

autocmd('CmdLineLeave', {
  group = group_redraw_cmdline,
  callback = function()
    -- vim.o.cmdheight = 0
    if vim.o.number then
      vim.o.relativenumber = true
    end
  end,
})

vim.api.nvim_create_user_command('LspOn', function()
  local clients = vim.lsp.get_clients()
  local lsp_name = vim.tbl_map(function(client)
    return client.name
  end, clients)
  vim.notify(vim.inspect(lsp_name), vim.log.levels.INFO, { title = 'List Active LSP client', timeout = 5000 })
end, { desc = 'Get active lsp server' })
