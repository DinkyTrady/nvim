local lsp_ok, nvim_lsp = pcall(require, "lspconfig")
if not lsp_ok then
  return
end

local capabilities = {
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities(),
}

local function on_attach(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    local navic = require("nvim-navic")
    navic.attach(client, bufnr)
  end

  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end
  if client.name == "sumneko_lua" then
    client.server_capabilities.documentFormattingProvider = false
  end
end

for _, lsp in ipairs(require("mason-lspconfig").get_installed_servers()) do
  nvim_lsp[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

nvim_lsp.sumneko_lua.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
      },
    },
  },
})

nvim_lsp.clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = "●", -- Could be '■', '▎', 'x'
    spacing = 2,
  },
  update_in_insert = true,
})
