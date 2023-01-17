local lsp_ok, nvim_lsp = pcall(require, "lspconfig")
if not lsp_ok then
  return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local function on_attach(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    local navic = require("nvim-navic")
    navic.attach(client, bufnr)
  end

  if client.name == "tsserver" or client.name == "sumneko_lua" or client.name == "html" or client.name == "cssls" then
    client.server_capabilities.documentFormattingProvider = false
  end

  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", {
      clear = false,
    })
    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = "lsp_document_highlight",
    })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
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
          vim.fn.expand("$VIMRUNTIME"),
          require("neodev.config").types(),
        },

        maxPreload = 5000,
        preloadFileSize = 10000,
        -- library = {
        --   [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        --   [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        -- },
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
})

nvim_lsp.clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

require("configs.lsp.settings")
