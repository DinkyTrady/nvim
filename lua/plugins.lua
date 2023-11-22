return {
  -- { "dstein64/vim-startuptime",                cmd = "StartupTime" },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    cmd = "ColorizerToggle",
    config = true,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  { require("configs.alpha").config },
  { require("configs.gitsigns").config },
  { require("configs.indent-blankline").config },
  { require("configs.better-escape").config },
  { require("configs.comment").config },
  { require("configs.cmp").config },
  { require("configs.luasnip").config },
  { require("configs.lsp.lsp").config },
  { require("configs.lsp.mason").config },
  { require("configs.navic").config },
  { require("configs.telescope").config },
  { require("configs.whichkey").config },
  { require("configs.neo-tree").config },
  { require("configs.treesitter").config },
  { require("configs.devicons").config },
  { require("configs.bufferline").config },
  { require("configs.autopairs").config },
  { require("configs.term").config },
}
