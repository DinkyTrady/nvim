return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<C-k>", false, mode = "i" }
    end,
    opts = {
      servers = {
        lua_ls = {
          mason = false,
        },
        html = {
          mason = true,
        },
        cssls = {
          mason = true,
        },
        emmet_ls = {
          mason = true,
        },
        clangd = {
          mason = false,
        },
      },
    },
  },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
  --
  --     -- local formatter = { "prettier", "stylua", "shfmt" }
  --     -- local nls = require("null-ls")
  --
  --     opts.on_attach = function(client, bufnr)
  --       if client.supports_method("textDocument/formatting") then
  --         vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --         vim.api.nvim_create_autocmd("BufWritePre", {
  --           group = augroup,
  --           buffer = bufnr,
  --           callback = function()
  --             -- on 0.7, use vim.lsp.buf.formatting_sync() instead
  --             vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 1500 })
  --           end,
  --         })
  --       end
  --     end
  --
  --     return opts
  --   end,
  -- },
  {
    "j-hui/fidget.nvim",
    tag = "v1.0.0",
    event = "LazyFile",
    opts = function()
      return {}
    end,
  },
}
