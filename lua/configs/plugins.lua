vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
  return
end

packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return packer.startup(function(use)
  -- make packer setu itself
  use({
    "wbthomason/packer.nvim",
    module = "packer",
    cmd = require("core.commands").packer,
    config = function()
      require("configs.plugins")
    end,
  })

  --mostly used for many plugins
  use({
    "nvim-lua/plenary.nvim", --[[ opt = true, ]]
    module = "plenary",
  })
  use({ "nvim-lua/popup.nvim", opt = true, module = "popup" })

  -- For fast open neovim
  use({ "lewis6991/impatient.nvim" })
  -- Chechk startup time
  use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

  -- for icon in neovim
  use({
    "nvim-tree/nvim-web-devicons",
    opt = true,
    event = "VimEnter",
    requires = { { "DaikyXendo/nvim-material-icon", opt = true, module = "nvim-material-icon" } },
    config = function()
      require("configs.others").devicons()
    end,
  })

  -- colorscheme
  --use({
  --"folke/tokyonight.nvim",
  --setup = function()
  --require("core.commands").on_file_open "tokyonight.nvim"
  --end,
  --config = function()
  --require("configs.tokyonight")
  --end,
  --})

  use({
    "NvChad/nvim-colorizer.lua",
    opt = true,
    cmd = "ColorizerToggle",
    config = function()
      require("colorizer").setup()
    end,
  })

  use({
    "nvim-treesitter/nvim-treesitter",
    module = "nvim-treesitter",
    setup = function()
      require("core.commands").on_file_open("nvim-treesitter")
    end,
    cmd = require("core.commands").treesitter,
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
      require("configs.treesitter")
    end,
  })

  use({
    "windwp/nvim-ts-autotag",
    after = "nvim-treesitter",
  })

  use({
    "p00f/nvim-ts-rainbow",
    after = "nvim-treesitter",
  })

  use({
    "JoosepAlviste/nvim-ts-context-commentstring",
    after = "nvim-treesitter",
  })

  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    module = "neo-tree",
    cmd = require("core.commands").neo_tree,
    config = function()
      require("configs.tree")
    end,
    requires = { { "MunifTanjim/nui.nvim", opt = true, module = "nui" } },
  })

  use({
    "nvim-telescope/telescope.nvim",
    opt = true,
    cmd = "Telescope",
    -- cmd = require("core.commands").telescope, --[[ require("core.commands").telescope ]]
    module = "telescope",
    config = function()
      require("configs.telescope")
    end,
  })

  use({
    "nvim-telescope/telescope-file-browser.nvim",
    opt = true,
    after = "telescope.nvim",
    config = function()
      require("telescope").load_extension("file_browser")
    end,
    -- module = "file_browser",
  })

  use({
    "neovim/nvim-lspconfig",
    opt = true,
    module = "lspconfig",
    setup = function()
      require("core.commands").on_file_open("nvim-lspconfig")
    end,
    config = function()
      require("configs.lsp.lsp")
    end,
  })

  use({
    "glepnir/lspsaga.nvim",
    module = "lspsaga",
    after = "nvim-lspconfig",
    config = function()
      require("configs.lsp.lspsaga")
    end,
  })

  use({
    "williamboman/mason.nvim",
    opt = true,
    cmd = require("core.commands").mason,
    module = "mason",
    config = function()
      require("configs.lsp.mason")
    end,
  })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    module = "null-ls",
    after = "nvim-lspconfig",
    config = function()
      require("configs.lsp.null-ls")
    end,
  })

  use({
    "williamboman/mason-lspconfig.nvim",
    opt = true,
    cmd = require("core.commands").mason_lsp,
    module = "mason-lspconfig",
    config = function()
      require("configs.lsp.masonlsp")
    end,
  })

  use({
    "SmiteshP/nvim-navic",
    opt = true,
    after = "nvim-lspconfig",
    module = "nvim-navic",
    setup = function()
      require("core.commands").on_file_open("nvim-navic")
    end,
    config = function()
      require("configs.others").navic()
    end,
  })

  -- Completion

  use({
    "rafamadriz/friendly-snippets",
    opt = true,
    event = "InsertEnter",
    module = { "cmp", "cmp_nvim_lsp" },
  })

  use({
    "hrsh7th/nvim-cmp",
    opt = true,
    module = "cmp",
    after = "friendly-snippets",
    config = function()
      require("configs.completion")
    end,
  })

  use({
    "L3MON4D3/LuaSnip",
    opt = true,
    module = "luasnip",
    wants = "friendly-snippets",
    after = "nvim-cmp",
    config = function()
      require("configs.snippets")
    end,
  })

  use({
    "saadparwaiz1/cmp_luasnip",
    after = "LuaSnip",
  })

  use({
    "hrsh7th/cmp-nvim-lsp",
    after = "nvim-cmp",
  })

  use({
    "hrsh7th/cmp-nvim-lsp-signature-help",
    after = "cmp-nvim-lsp",
  })

  use({
    "hrsh7th/cmp-path",
    after = "nvim-cmp",
  })

  use({
    "hrsh7th/cmp-buffer",
    after = "nvim-cmp",
  })

  use({
    "akinsho/bufferline.nvim",
    disable = true,
    tah = "v3.*",
    event = "UIEnter",
    config = function()
      require("configs.others").bufferline()
    end,
  })

  use({
    "nvim-lualine/lualine.nvim",
    disable = true,
    event = "UIEnter",
    config = function()
      require("configs.lualine")
    end,
  })

  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    cmd = "MarkdownPreview",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  })

  use({
    "lewis6991/gitsigns.nvim",
    opt = true,
    -- cmd = "Gitsigns",
    -- module = "gitsigns",
    ft = "gitcommit",
    setup = function()
      require("core.commands").gitsigns()
    end,
    config = function()
      require("configs.others").gitsigns()
    end,
  })

  use({
    "lukas-reineke/indent-blankline.nvim",
    opt = true,
    setup = function()
      require("core.commands").on_file_open("indent-blankline.nvim")
    end,
    config = function()
      require("configs.others").indentline()
    end,
  })

  use({
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("configs.autopairs")
    end,
  })

  use({
    "numToStr/Comment.nvim",
    module = { "Comment", "Comment.api" },
    keys = { "gc", "gb" },
    config = function()
      require("configs.others").comment()
    end,
  })

  use({
    "karb94/neoscroll.nvim",
    disable = true,
    module = "neoscroll",
    after = "nvim-treesitter",
    config = function()
      require("configs.others").neoscroll()
    end,
  })

  use({
    "goolord/alpha-nvim",
    cmd = "Alpha",
    module = "alpha",
    event = "VimEnter",
    config = function()
      require("configs.alpha")
    end,
  })

  use({
    "folke/which-key.nvim",
    cmd = "WhichKey",
    key = { "<leader>", "`", "'", "@", '"' },
    after = "indent-blankline.nvim",
    config = function()
      require("configs.whichkey")
    end,
  })

  use({
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("configs.others").better_escape()
    end,
  })
end)
