local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
  return
end

local diff = {
  "diff",
  symbols = { added = " ", modified = "柳 ", removed = " " },
  diff_color = {
    added = { fg = "#00ff00" },
    modified = { fg = "#ffdd00" },
    removed = { fg = "#ff0000" },
  },
  padding = { left = 1, right = 0 },
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " " },
  -- diagnostics_color = {
  --   color_error = { fg = "red" },
  --   color_warn = { fg = "yellow" },
  --   color_info = { fg = "cyan" },
  -- },
}

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = {
      right = "",
      left = "",--[[ / ]]
    },
    section_separators = { right = " ", left = "" },
    fmt = string.lower,
    disabled_filetypes = {
      "packer",
      "alpha",
      -- statusline = {},
      -- winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = false,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { {
      "mode",
      fmt = function(str)
        return str:sub(1, 1)
      end,
    } },
    lualine_b = { "filetype", { "filesize", padding = { right = 1 } } },
    lualine_c = { { "branch", icon = "", color = { fg = "#ff0000" } } },
    lualine_x = { diagnostics, diff },
    lualine_y = { { "progress", padding = { left = 1 } } },
    lualine_z = { { "location", padding = { right = 1 } } },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
