local M = {}

M.config = {
  "nvim-treesitter/nvim-treesitter",
  -- event = "BufRead",
  build = ":TSUpdate",
  init = function()
    require("core.commands").lazyload("nvim-treesitter")
  end,
  cmd = require("core.commands").treesitter,
  config = function()
    require("configs.treesitter").setup()
  end,
  dependencies = {
    "windwp/nvim-ts-autotag",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
}

function M.setup()
  local status, ts = pcall(require, "nvim-treesitter.configs")
  if not status then
    return
  end

  ts.setup({
    ensure_installed = {
      "lua",
      "javascript",
      "html",
      "c",
      "cpp",
      "json",
      "markdown",
    },
    sync_install = false,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    autotag = {
      enable = true,
      disable = { "xml", "markdown" },
      filetypes = {
        "html",
        "javascript",
        "javascriptreact",
        "svelte",
        "typescript",
        "typescriptreact",
        "vue",
      },
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  })
end

return M
