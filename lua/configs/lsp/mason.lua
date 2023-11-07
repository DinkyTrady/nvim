local M = {}

M.config = {
  "williamboman/mason.nvim",
  cmd = require("core.commands").mason,
  config = function()
    require("configs.lsp.mason").setup()
  end,
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    cmd = require("core.commands").mason_lsp,
    config = function()
      require("configs.lsp.mason-lspconfig").setup()
    end,
  },
}

function M.setup()
  local status, mason = pcall(require, "mason")
  if not status then
    return
  end

  mason.setup({
    ui = {
      border = "rounded",
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })
end

return M
