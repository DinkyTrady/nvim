local lualine_ok, lualine = pcall(require, 'lualine')
if not lualine_ok then return end

local diff = {
  'diff',
  sources = {'nvim_diagnostic'},
  symbols = { added = ' ', modified = '柳 ', removed = ' ' },
  diff_color = {
    added = { fg = '#00ff00' },
    modified = { fg = '#ffdd00' },
    removed = { fg = '#ff0000' },
  },
}

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = {right = "/", left = '\\'},
    section_separators = {right = '', left = '' },
    fmt = string.lower,
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = false,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = --[[ process_sections ]] {
    lualine_a = {{ 'mode', fmt = function(str) return str:sub(1,1) end }},
    lualine_b = {'filetype', 'filesize' },
    lualine_c = { diff, 'diagnostics' },
    lualine_x = {{'branch', icon = '', color = {fg='#ff0000'}}},
    lualine_y = { 'progress', 'fileformat' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
