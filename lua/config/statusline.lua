---Show attached LSP clients in `[name1, name2]` format.
---Returns an empty string if there aren't any attached LSP clients.
---@return string
local function lsp_status()
  local attached_clients = vim.lsp.get_clients { bufnr = 0 }
  if #attached_clients == 0 then
    return ''
  end
  local names = vim
    .iter(attached_clients)
    :map(function(client)
      local name = client.name:gsub('language.server', 'ls')
      return name
    end)
    :totable()
  return '[' .. table.concat(names, ', ') .. ']'
end

---Get diagnostic counts for the current buffer
---@return string
local function get_diagnostics()
  local diagnostics = vim.diagnostic.count(0)
  if not diagnostics or vim.tbl_isempty(diagnostics) then
    return ''
  end

  -- Get the signs from vim's sign definitions
  local function get_sign_text(name)
    local sign = vim.fn.sign_getdefined('DiagnosticSign' .. name)[1]
    return sign and sign.text or ''
  end

  local result = {}
  local severities = {
    ['Error'] = vim.diagnostic.severity.ERROR,
    ['Warn'] = vim.diagnostic.severity.WARN,
    ['Info'] = vim.diagnostic.severity.INFO,
    ['Hint'] = vim.diagnostic.severity.HINT,
  }

  for name, severity in pairs(severities) do
    local count = diagnostics[severity] or 0
    if count > 0 then
      local icon = get_sign_text(name)
      table.insert(result, '%#DiagnosticSign' .. name .. '#' .. icon .. count .. '%*')
    end
  end

  if #result == 0 then
    return ''
  end

  return table.concat(result, ' ')
end

---@return string, string
local function get_icons_and_color(category, type)
  local mini_icons_ok, icons = pcall(require, 'mini.icons')
  if not mini_icons_ok then
    return '?', 'DiagnosticWarn'
  end

  local icon_ok, icon, hl_group = pcall(function()
    return icons.get(category, type)
  end)

  if not icon_ok then
    return '?', 'DiagnosticWarn'
  end

  return icon, hl_group
end

---@return string
local function filename()
  local bufnr = vim.bo
  local ft = bufnr.filetype
  vim.api.nvim_set_hl(0, 'StatusLineModified', { fg = '#dc8a78', bold = true })
  vim.api.nvim_set_hl(0, 'StatusLineReadOnly', { fg = '#a6adc8', bold = true })
  vim.api.nvim_set_hl(0, 'StatusLineHelp', { fg = '#74c7ec', bold = true })

  local file_name = vim.fn.expand '%:t'
  local is_unnamed = file_name == '' or file_name == nil

  local components = {}

  if ft == 'snacks_dashboard' then
    table.insert(components, '[-]')
  elseif not is_unnamed then
    local icon, hl_group = get_icons_and_color('filetype', ft)
    table.insert(components, '%#' .. hl_group .. '#' .. icon .. ' ' .. file_name .. '%*')
  else
    if ft == '' then
      table.insert(components, '[No Name]')
    else
      table.insert(components, ft)
    end
  end

  if bufnr.modified then
    table.insert(components, '%#StatusLineModified#' .. '[+]' .. '%*')
  end

  if bufnr.readonly then
    table.insert(components, '%#StatusLineReadOnly#' .. '[RO]' .. '%*')
  end

  if bufnr.filetype == 'help' then
    table.insert(components, '%#StatusLineHelp#' .. '[Help]' .. '%*')
  end

  return table.concat(components, ' ')
end

---@return string
local function directory()
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
  local icon, _ = get_icons_and_color('directory', cwd)

  return '%#Number#' .. icon .. ' ' .. cwd .. '%*'
end

function _G.statusline()
  return table.concat({
    ' ',
    directory(),
    '▎',
    filename(),
    '%=',
    lsp_status(),
    ' ',
    get_diagnostics(),
    '%=',
    ' %-14(%l,%c%V%)',
    '%P',
    ' ',
  }, ' ')
end
