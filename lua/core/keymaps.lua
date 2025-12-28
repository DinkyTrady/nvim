vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local map = function(mode, map, mapdo, desc)
  vim.keymap.set(mode, map, mapdo, { noremap = true, silent = true, desc = desc })
end

local function toggle_list(wininfo_key, open_cmd, close_cmd, label)
  local ok, err = pcall(function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.fn.getwininfo(win)[1][wininfo_key] == 1 then
        vim.cmd(close_cmd)
        return
      end
    end
    vim.cmd(open_cmd)
  end)
  if not ok then
    vim.notify(label .. ' Error: ' .. err, vim.log.levels.ERROR)
  end
end

map('n', '<Esc>', '<Cmd>noh<Cr>')
map('n', 'H', '<Cmd>bn<Cr>')
map('n', 'L', '<Cmd>bp<Cr>')
map('n', '<ScrollWheelUp>', '<C-y><C-y><C-y><C-y><C-y>')
map('n', '<ScrollWheelDown>', '<C-e><C-e><C-e><C-e><C-e>')

-- only copy using leader so it will not poluted clipboard
map({ 'n', 'v', 'x' }, '<leader>y', '"+y')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d')
-- paste from clipboard
map({ 'n', 'v', 'x' }, '<leader>P', '"+P')
map({ 'n', 'v', 'x' }, '<leader>p', '"+p')

-- diagnostic
map('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end)
map('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end)
map('n', 'gro', vim.diagnostic.open_float, 'Open Float Diagnostic')
map('n', '<leader>d', function()
  local win = vim.api.nvim_get_current_win()
  vim.diagnostic.setloclist { open = true }
  vim.api.nvim_set_current_win(win)
end, 'Set diagnostic to loclist')
map('n', '<leader>D', function()
  local win = vim.api.nvim_get_current_win()
  vim.diagnostic.setqflist { open = true }
  vim.api.nvim_set_current_win(win)
end, 'Set diagnostic to quickfix')

-- Quickfix and Loclist
--- toggling open/close
map('n', '<leader>l', function()
  toggle_list('loclist', 'lopen', 'lclose', 'Location List')
end, 'Toggle Location List')
map('n', '<leader>q', function()
  toggle_list('quickfix', 'copen', 'cclose', 'Toggle Quickfix List')
end, 'Toggle Quickfix List')

--- better quickfix navigation
map('n', ']q', function()
  if vim.tbl_isempty(vim.fn.getqflist()) then
    vim.notify('Quickfix list is empty', vim.log.levels.WARN)
    return
  end

  local ok_cnext = pcall(vim.cmd, 'cnext')
  if not ok_cnext then
    vim.cmd 'cfirst'
  end
end, 'Next Quickfix')
map('n', '[q', function()
  if vim.tbl_isempty(vim.fn.getqflist()) then
    vim.notify('Quickfix list is empty', vim.log.levels.WARN)
    return
  end

  local ok = pcall(vim.cmd, 'cprev')
  if not ok then
    vim.cmd 'clast'
  end
end, 'Prev Quickfix')

--- better loclist navigation
map('n', ']l', function()
  if vim.tbl_isempty(vim.fn.getloclist(0)) then
    vim.notify('Location list is empty', vim.log.levels.WARN)
    return
  end

  local ok = pcall(vim.cmd, 'lnext')
  if not ok then
    vim.cmd 'lfirst'
  end
end, 'Next Location list')
map('n', '[l', function()
  if vim.tbl_isempty(vim.fn.getloclist(0)) then
    vim.notify('Location list is empty', vim.log.levels.WARN)
    return
  end

  local ok = pcall(vim.cmd, 'lprev')
  if not ok then
    vim.cmd 'llast'
  end
end, 'Prev Location list')

-- move window
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- insert mode
map('i', '<A-k>', '<Esc>v:m .-2<CR>==gi')
map('i', '<A-j>', '<Esc>v:m .+1<CR>==gi')

--- move cursor
-- map('i', '<C-h>', '<Left>')
-- map('i', '<C-j>', '<Down>')
-- map('i', '<C-k>', '<Up>')
-- map('i', '<C-l>', '<Right>')

-- visual mode
map({ 'v', 'x' }, 'K', ':m .-2<CR>gv')
map({ 'v', 'x' }, 'J', ':m .+1<CR>gv')
