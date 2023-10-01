local M = {}

local filetypes = {
  "qf",
  "toggleterm",
  "diff",
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
  "lazy",
  "alpha",
  "",
  -- "",
}

local fn = vim.fn
vim.api.nvim_set_hl(0, "edited", { fg = "#9ece6a" })

local sep = function()
  for _, fileIgnore in ipairs(filetypes) do
    if vim.bo.filetype == fileIgnore then
      return ""
    end
  end
  return "%#Empty#" .. " > " .. "%*"
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
