local util = require 'core.util'

local function get_diagnostic_sign()
  local cur_buf = vim.api.nvim_get_current_buf()
  if not util.filetypes.should_ignore() then
    local lnum = vim.v.lnum - 1 -- 0-based indexing
    local severities = {
      { name = 'Error', hl = 'DiagnosticSignError', severity = vim.diagnostic.severity.ERROR },
      { name = 'Warn', hl = 'DiagnosticSignWarn', severity = vim.diagnostic.severity.WARN },
      { name = 'Hint', hl = 'DiagnosticSignHint', severity = vim.diagnostic.severity.HINT },
      { name = 'Info', hl = 'DiagnosticSignInfo', severity = vim.diagnostic.severity.INFO },
    }

    for _, s in ipairs(severities) do
      local diags = vim.diagnostic.get(cur_buf, { lnum = lnum, severity = s.severity })
      if #diags > 0 then
        return '%#' .. s.hl .. '#' .. util.diagnostics.signs[s.name] .. '%*'
      end
    end
  end

  return ' '
end

local function fold_indicator()
  local lnum = vim.v.lnum

  if vim.fn.foldlevel(lnum) > 0 and vim.fn.foldlevel(lnum) == vim.fn.foldlevel(lnum - 1) + 1 then
    if vim.fn.foldclosed(lnum) == -1 then
      return '▾'
    else
      return '▸'
    end
  else
    return ' '
  end
end

_G.custom_statuscolumn = function()
  return table.concat({
    ' ',
    get_diagnostic_sign(),
    ' ',
    '%l %s',
    fold_indicator(),
  }, '')
end

vim.o.statuscolumn = '%!v:lua.custom_statuscolumn()'
