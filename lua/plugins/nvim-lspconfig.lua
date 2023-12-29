return {
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
    },
  },
}
