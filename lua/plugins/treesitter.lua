return {
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    require("nvim-treesitter.configs").setup({

    ensure_installed = {
      "lua",
      "vim",
      "markdown",
      'markdown_inline',
      "json",
      'html',
      'css',
      'javascript',
      'tsx'
    },
    highlight = { enable = true },
    indent = { enable = true },
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
    })
  
  end
}
