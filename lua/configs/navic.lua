local M = {}

M.config = {
  "SmiteshP/nvim-navic",
  event = "BufRead",
  config = function()
    require("configs.navic").setup()
    vim.o.winbar = "%{%v:lua.require'core.ui.winbar'.setup()%}"
  end,
}

function M.setup()
  local status, navic = pcall(require, "nvim-navic")
  if not status then
    return
  end

  navic.setup({
    icons = {
      File = " ",
      Module = " ",
      Namespace = " ",
      Package = " ",
      Class = " ",
      Method = " ",
      Property = " ",
      Field = " ",
      Constructor = " ",
      Enum = " ",
      Interface = " ",
      Function = " ",
      Variable = " ",
      Constant = " ",
      String = " ",
      Number = " ",
      Boolean = " ",
      Array = " ",
      Object = " ",
      Key = " ",
      Null = " ",
      EnumMember = " ",
      Struct = " ",
      Event = " ",
      Operator = " ",
      TypeParameter = " ",
    },
    highlight = true,
  })
end

return M
