-- Setup lspconfig.
local mason = require("mason-lspconfig")
mason.setup({
  ensure_installed = { 'sumneko_lua', 'html', 'cssls', 'tsserver', 'emmet_ls', 'eslint' },
  automatic_installation = false
})
local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

for _,lsp in ipairs(mason.get_installed_servers()) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
  }
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " } 
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl= hl, numhl = hl })
end
