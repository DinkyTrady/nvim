local M = {}

M.config = {
  "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  config = function()
    require("configs.devicons").setup()
  end,
  dependencies = { "NotNullBool/nvim-material-icon" },
}

function M.setup()
  local dev_icon_ok, dev = pcall(require, "nvim-web-devicons")
  if not dev_icon_ok then
    return
  end

  local material_icon_ok, material_icon = pcall(require, "nvim-material-icon")
  if not material_icon_ok then
    return
  end

  material_icon.setup({
    override = {
      json = {
        icon = "",
        color = "#cbcb41",
        cterm_color = "185",
        name = "Json",
      },
      json5 = {
        icon = "",
        color = "#cbcb41",
        cterm_color = "185",
        name = "Json5",
      },
      jsx = {
        icon = "",
        color = "#519aba",
        cterm_color = "67",
        name = "Jsx",
      },
      tsx = {
        icon = "",
        color = "#519aba",
        cterm_color = "67",
        name = "Tsx",
      },
      ts = {
        icon = " ﯤ ",
        color = "#519aba",
        cterm_color = "67",
        name = "Ts",
      },
    },
  })

  dev.setup({
    override = material_icon.get_icons(),
    default = true,
  })
end

return M
