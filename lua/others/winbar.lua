local M = {}

local status, dev = pcall(require, "nvim-web-devicons")
if not status then
  return
end

local status2, navic = pcall(require, "nvim-navic")
if not status2 then
  return
end

vim.api.nvim_set_hl(0, "ModifColors", { fg = "#98c379" })

M.config = function()
  -- to get icon and colors it
  local filename = vim.fn.expand("%:t")
  local extension = vim.fn.expand("%:e")
  local file_icon, icon_colors = dev.get_icon_color(filename, extension, { default = true })
  vim.api.nvim_set_hl(0, "hl_icon", { fg = tostring(icon_colors) })

  -- to show filename
  local name_file = vim.api.nvim_eval_statusline("%t", {}).str

  -- to show the current buffer is modified or not
  local modif = vim.api.nvim_eval_statusline("%M", {}).str == "+" and " ● " or " "

  -- to get navic location
  local were = "> " .. navic.get_location()

  -- will return value we all declared before

  local winbar_filetype_exclude = {
    "help",
    "terminal",
    "packer",
    "neogitstatus",
    "neo-tree",
    "Trouble",
    "alpha",
    "toggleterm",
    "lspsagaoutline",
    "startuptime",
    "tsplayground",
    "telescope",
    "noice",
    "notify",
    "",
  }

  -- local winbar_exclude_term = {
  --   "bash",
  --   "zsh",
  --   "fish",
  -- }

  if
    vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype)--[[  or vim.tbl_contains(winbar_exclude_term, filename) ]]
  then
    return " "
  else
    return table.concat({
      " " .. "%#hl_icon#" .. file_icon .. " " .. "%*" .. name_file .. "%*" .. "%#ModifColors#" .. modif .. "%*" .. were,
    })
  end
end

M.setup = function()
  vim.opt.winbar = "%{%v:lua.require('others.winbar').config()%}"
  -- vim.api.nvim_create_autocmd("LspAttach", {
  --   callback = function()
  --     vim.opt.winbar = "%{%v:lua.require'others.winbar'.config()%}"
  --   end,
  -- })
end

return M
