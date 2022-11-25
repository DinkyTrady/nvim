local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  return
end

local masonlsp_ok, masonlsp = pcall(require, "mason-lspconfig")
if not masonlsp_ok then
  return
end

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

masonlsp.setup({
  ensure_installed = { "html", "cssls", "tsserver", "emmet_ls", "jsonls" },
  automatic_installation = false,
})
