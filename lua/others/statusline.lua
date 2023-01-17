local fn = vim.fn
local api = vim.api

-- set colors of lock
api.nvim_set_hl(0, "lock", { fg = "yellow" })

-- set bar left
api.nvim_set_hl(0, "Sep", { fg = "#61efef" })

-- git name
api.nvim_set_hl(0, "git_name", {
  bg = "red",
  fg = "white",--[[ , bold = true ]]
})

local modes = {
  ["n"] = { "", "normalmode" },
  ["niI"] = { "", "normalmode" },
  ["niR"] = { "", "normalmode" },
  ["niV"] = { "", "normalmode" },
  ["no"] = { "", "normalmode" },
  ["i"] = { "", "Insert" },
  ["ic"] = { "", "Insert" },
  ["ix"] = { "", "Insert" },
  ["t"] = { "", "Terminal" },
  ["nt"] = { "", "normalmode" },
  ["v"] = { "", "visualmode" },
  ["V"] = { "", "visualmode" },
  ["Vs"] = { "", "visualmode" },
  [""] = { "", "visualmode" },
  ["R"] = { "", "Replace" },
  ["Rv"] = { "", "Replace" },
  ["s"] = { "", "visualmode" },
  ["S"] = { "", "visualmode" },
  [""] = { "", "visualmode" },
  ["c"] = { "", "Command" },
  ["cv"] = { "", "Command" },
  ["ce"] = { "", "Command" },
  ["r"] = { "", "ConfirmMode" },
  ["rm"] = { "", "ConfirmMode" },
  ["r?"] = { "", "ConfirmMode" },
  ["!"] = { "", "Terminal" },
}

local filetypes = {
  "TelescopePrompt",
  "mason",
  "lspinfo",
  "lspsagaoutline",
  "neo-tree",
  "neo-tree-popup",
  "startuptime",
  "noice",
  "packer",
  "tsplayground",
  "sagarename",
  "sagacodeaction",
  "null-ls-info",
  "lspsagafinder",
  "notify",
  -- "",
}

local sep = function()
  return "%#Sep#" .. "▊" .. "%*"
end

--set modes
local mode = function()
  local m = vim.api.nvim_get_mode().mode
  local current_mode = "%#" .. modes[m][2] .. "#" .. "   " .. modes[m][1]

  return current_mode .. "" .. "%*"
end

-- filetype with icons
local filetype = function()
  local status, dev = pcall(require, "nvim-web-devicons")
  if not status then
    return
  end

  local filename, extension = fn.expand("%:t"), fn.expand("%:e")
  local file_icon, icon_colors = dev.get_icon_color(filename, extension, { default = true })
  local type = string.format(" %s ", vim.bo.filetype):lower()

  -- to set color
  api.nvim_set_hl(0, "hl_icon", { bg = tostring(icon_colors), fg = "#000000", bold = true })
  api.nvim_set_hl(0, "Empty", { fg = "white" })

  api.nvim_set_hl(0, "sepicon", { fg = tostring(icon_colors) })
  api.nvim_set_hl(0, "sepiconright", { fg = tostring(icon_colors), bg = "red" })

  for _, fileignore in ipairs(filetypes) do
    if vim.bo.filetype == fileignore then
      local file_icon = " "
      return "%#lock#" .. file_icon .. "%*" .. "%#linestatus#" .. type .. "%*"
    end
  end

  if filename == "bash" then
    return "%#sepicon#" .. " " .. "%#hl_icon#" .. "  Terminal " .. "%*" .. "%#sepicon#" .. " " .. "%*"
  end

  if vim.bo.filetype == "alpha" then
    return ""
  end

  if vim.bo.filetype == "" then
    return "%#Empty#" .. "  Empty " .. "%*"
  end

  return "%#sepicon#" .. " " .. "%#hl_icon#" .. " " .. file_icon .. type .. "%*" .. "%#sepicon#" .. " " .. "%*"
end

local diagnostics = function()
  if not rawget(vim, "lsp") then
    return ""
  end
  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

  errors = (errors and errors > 0) and ("%#DiagnosticError#" .. " " .. errors .. " ") or ""
  warnings = (warnings and warnings > 0) and ("%#DiagnosticWarn#" .. " " .. warnings .. " ") or ""
  hints = (hints and hints > 0) and ("%#DiagnosticHint#" .. " " .. hints .. " ") or ""
  info = (info and info > 0) and ("%#DiagnosticInfo#" .. " " .. info .. " ") or ""

  return errors .. warnings .. hints .. info .. "%*"
end

local git_head = function()
  if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
    return ""
  end

  local git_status = vim.b.gitsigns_status_dict
  local branch_name = "  " .. git_status.head .. " "
  return "%#git_head#" .. " " .. "%#git_name#" .. branch_name .. "%#git_head#" .. "  "
end

local git = function()
  if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
    return ""
  end

  local git_status = vim.b.gitsigns_status_dict

  local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added .. " ") or ""
  local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed .. " ") or ""
  local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed .. " ") or ""

  return "%#GitSignsAdd#" .. added .. "%#GitSignsChange#" .. changed .. "%#GitSignsDelete#" .. removed
end

local dir = function()
  local dir_icon = " "
  local dir_name = " " .. fn.fnamemodify(fn.getcwd(), ":t") .. " "
  return (
    vim.o.columns >= 95
    and ("%#dir_sep#" .. "" .. "%*" .. "%#dir#" .. dir_icon .. dir_name .. "%*" .. "%#dir_sep#" .. "" .. "%*")
  ) or ""
end

-- whereare we now?
local cursor_position = function()
  local current_line = fn.line(".")
  local total_line = fn.line("$")
  local text = math.modf((current_line / total_line) * 100) .. tostring("%%")

  text = (current_line == 1 and "Top") or text
  text = (current_line == total_line and "Bot") or text

  return "%#linestatus#" .. " %l:%c" .. " " .. text .. " "
end

local progress = function()
  local current_line = fn.line(".")
  local total_lines = fn.line("$")
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return "%#Sep#" .. chars[index]
end

local M = {}

M.config = function()
  return table.concat({
    sep()
      .. mode()
      .. filetype()
      .. git_head()
      .. diagnostics()
      .. "%="
      .. dir()
      .. "%="
      .. git()
      .. cursor_position()
      .. progress(),
  })
end

M.setup = function()
  api.nvim_create_autocmd("UIEnter", {
    callback = function()
      vim.opt.statusline = "%{%v:lua.require'others.statusline'.config()%}"
    end,
  })
end

return M
