local M = {}

local fn = vim.fn
vim.api.nvim_set_hl(0, "edited", { fg = "#9ece6a" })

local sep = function()
  if next(vim.lsp.buf_get_clients(0)) ~= nil and require("nvim-navic").get_location() ~= "" then
    return "%#Empty#" .. " > " .. "%*"
  end
  return ""
end

local fileName = function()
  if vim.bo.filetype == "alpha" then
    return ""
  else
    return "%#Empty#" .. fn.expand("%:t")
  end
end

local function modified()
  if vim.bo.modified then
    return "%#edited#" .. " ●" .. "%*"
  elseif vim.bo.modifiable == false or vim.bo.readonly == true then
    return " "
  end
  return ""
end

M.setup = function()
  return table.concat({
    " ",
    fileName(),
    modified(),
    sep(),
    require("nvim-navic").get_location(),
  })
end

return M
