local M = {}

M.config = {
  "neovim/nvim-lspconfig",
  cmd = require("core.commands").lsp,
  init = function()
    require("core.commands").lazyload("nvim-lspconfig")
  end,
  config = function()
    require("configs.lsp.lsp").setup()
  end,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require("configs.lsp.null-ls")
      end,
    },
    {
      "glepnir/lspsaga.nvim",
      cmd = "Lspsaga",
      config = function()
        require("lspsaga").setup({ symbol_in_winbar = { enable = false } })
      end,
    },
  },
}

function M.setup()
  require("lspconfig")
  local status, lsp = pcall(require, "lspconfig")
  if not status then
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

    if client.name == "tsserver" or client.name == "html" or client.name == "cssls" then
      client.server_capabilities.documentFormattingProvider = false
    end

    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = "LspFormatting",
        callback = function()
          vim.lsp.buf.format()
        end,
      })
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

  for _, lsp_name in ipairs(require("mason-lspconfig").get_installed_servers()) do
    lsp[lsp_name].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end

  lsp.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      lua = {
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  })

  lsp.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  require("configs.lsp.settings")
end

return M
