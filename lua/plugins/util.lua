return {
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {
      clear_empty_lines = true,
      mapping = { "jj", "kk" },
    },
  },
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6", --recomended as each new version will have breaking changes
    opts = {},
  },
  { "echasnovski/mini.surround", event = "BufRead", opts = {} },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "VeryLazy",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
}
