local M = {}

M.config = {
  "williamboman/mason.nvim",
  cmd = require("core.commands").mason,
  config = function()
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
  end,
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    cmd = require("core.commands").mason_lsp,
    config = function()
      local masonlsp_ok, masonlsp = pcall(require, "mason-lspconfig")
      if not masonlsp_ok then
        return
      end

      masonlsp.setup({
        ensure_installed = { "html", "cssls", "tsserver", "emmet_ls", "jsonls", "eslint" },
        automatic_installation = false,
      })
    end,
  },
}

return M
