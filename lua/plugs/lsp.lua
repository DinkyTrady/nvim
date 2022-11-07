local lsp_ok, nvim_lsp = pcall(require, 'lspconfig')
if not lsp_ok then
  return
end

local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then
  return
end

local masonlsp_ok, masonlsp = pcall(require, 'mason-lspconfig')
if not masonlsp_ok then
  return
end

mason.setup({
  ui = {
    icons = {
       package_installed = "✓",
       package_pending = "➜",
       package_uninstalled = "✗"
    }
  }
})

masonlsp.setup({
  ensure_installed = { 'html', 'cssls', 'tsserver', 'emmet_ls' },
  automatic_installation = false,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

for _,lsp in ipairs(masonlsp.get_installed_servers()) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
  }
end

nvim_lsp.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true
        }
      },
    },
  },
}

nvim_lsp.clangd.setup {
  capabilities = capabilities,
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl= hl, numhl = hl })
end

