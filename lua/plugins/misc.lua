-- This file contains helper that not really necessary but useful
return {
  {
    'folke/flash.nvim',
    event = 'BufRead',
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      -- { "r", mode = "x", function() require("flash").remote() end, desc = "Remote Flash" },
      -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "x", "n" },      function() require("flash").toggle() end,     desc = "Toggle Flash Search" },
    },
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    opts = {},
  },
  {
    'vyfor/cord.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'altermo/ultimate-autopair.nvim',
    enabled = true,
    event = { 'InsertEnter', 'CmdlineEnter' },
    branch = 'v0.6', --recomended as each new version will have breaking changes
    opts = {},
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = true }
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },
  {
    'mistricky/codesnap.nvim',
    event = 'BufReadPost',
    build = 'make',
    opts = {
      title = '',
      code_font_family = 'FantasqueSansM Nerd Font',
      watermark = '',
      has_line_number = true,
      -- has_breadcrumbs = true,
      save_path = os.getenv 'XDG_PICTURES_DIR' or (os.getenv 'HOME' .. '/Pictures/codesnap'),
    },
  },
}
