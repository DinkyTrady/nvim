return {
  { "dstein64/vim-startuptime",                cmd = "StartupTime" },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    init = function()
      require("core.commands").lazyload("nvim-colorizer.lua")
    end,
    config = true,
  },
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup()
    end,
    ft = "lua",
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
