local masonlsp_ok, masonlsp = pcall(require, "mason-lspconfig")
if not masonlsp_ok then
  return
end

masonlsp.setup({
  ensure_installed = { "html", "cssls", "tsserver", "emmet_ls", "jsonls" },
  automatic_installation = false,
})
