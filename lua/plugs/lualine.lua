local lualine_ok, lualine = pcall(require, 'lualine')
if not lualine_ok then return end

local colors = {
  red = '#ca1243',
  grey = '#a0a1a7',
  black = '#383a42',
  white = '#f3f3f3',
  light_green = '#83a598',
  orange = '#fe8019',
  green = '#8ec07c',
}

-- Put proper separators and gaps between components in sections
-- local function process_sections(sections)
--   for name, section in pairs(sections) do
--     local left = name:sub(9, 10) < 'x'
--     for id, comp in ipairs(section) do
--       if type(comp) ~= 'table' then
--         comp = { comp }
--         section[id] = comp
--       end
--       comp.separator = left and { right = '' } or { left = '' }
--     end
--   end
--   return sections
-- end

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
    lualine_b = { {'filename', color = {gui='bold'}}, 'filesize' },
    lualine_c = { diff, 'diagnostics' },
    lualine_x = {{'branch', icon = '', color = {fg='#ff0000'}}},
    lualine_y = { {'filetype', icon_only = true}, 'progress' },
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
