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
          mason = true,
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
  {
    "j-hui/fidget.nvim",
    tag = "v1.0.0",
    event = "LazyFile",
    opts = function()
      return {}
    end,
  },
}
