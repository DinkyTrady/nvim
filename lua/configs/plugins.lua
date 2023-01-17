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
  -- make packer setup itself
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
    "nvim-lua/plenary.nvim",
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
    event = "UIEnter",
    requires = { { "DaikyXendo/nvim-material-icon", after = "nvim-web-devicons", module = "nvim-material-icon" } },
    config = function()
      require("configs.others").devicons()
    end,
  })

  -- syntax highlighting
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

  -- for html file or js family
  use({
    "windwp/nvim-ts-autotag",
    after = "nvim-treesitter",
  })

  -- better pairs highlighting
  use({
    "p00f/nvim-ts-rainbow",
    after = "nvim-treesitter",
  })

  -- not really used to be honest
  use({
    "JoosepAlviste/nvim-ts-context-commentstring",
    after = "nvim-treesitter",
  })

  -- for known what the syntax highlight
  use({
    "nvim-treesitter/playground",
    after = "nvim-treesitter",
  })

  -- bstter file explorer with buffer and git
  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    module = "neo-tree",
    cmd = require("core.commands").neo_tree,
    config = function()
      require("configs.neo-tree")
    end,
    requires = { { "MunifTanjim/nui.nvim", opt = true, module = "nui" } },
  })

  -- find file faster
  use({
    "nvim-telescope/telescope.nvim",
    opt = true,
    cmd = "Telescope",
    config = function()
      require("configs.telescope")
    end,
  })

  -- find directory
  use({
    "nvim-telescope/telescope-file-browser.nvim",
    after = "telescope.nvim",
    module = { "telescope", "file_browser" },
  })

  -- find projects
  use({
    "ahmedkhalf/project.nvim",
    after = "telescope.nvim",
    module = { "telescope", "projects" },
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern" },
        -- show_hidden = true,
        silent_chdir = true,
      })
      require("telescope").load_extension("projects")
    end,
  })

  -- builtin lsp
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

  -- diagnostic lsp ui
  use({
    "glepnir/lspsaga.nvim",
    module = "lspsaga",
    after = "nvim-lspconfig",
    config = function()
      require("configs.lsp.lspsaga")
    end,
  })

  -- use for support lsp builtin
  use({
    "jose-elias-alvarez/null-ls.nvim",
    module = "null-ls",
    after = "nvim-lspconfig",
    config = function()
      require("configs.lsp.null-ls")
    end,
  })

  -- helper for downloader like lsp, linter, formatter, and debug
  use({
    "williamboman/mason.nvim",
    opt = true,
    cmd = require("core.commands").mason,
    module = "mason",
    config = function()
      require("configs.lsp.mason")
    end,
  })

  -- helper for download lsp
  use({
    "williamboman/mason-lspconfig.nvim",
    opt = true,
    cmd = require("core.commands").mason_lsp,
    module = "mason-lspconfig",
    config = function()
      require("configs.lsp.masonlsp")
    end,
  })

  -- To know color
  use({
    "NvChad/nvim-colorizer.lua",
    opt = true,
    cmd = "ColorizerToggle",
    after = "nvim-lspconfig",
    config = function()
      require("colorizer").setup()
    end,
  })

  -- navigation to know current cursor in winbar
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

  -- Completion and snippets
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
      require("configs.cmp")
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

  -- ui of bufferline
  use({
    "akinsho/bufferline.nvim",
    -- disable = true,
    tag = "v3.*",
    event = "BufNew",
    config = function()
      require("configs.others").bufferline()
    end,
  })

  -- use for markdown
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    cmd = "MarkdownPreviewToggle",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  })

  --helper for what we add or delete or change shown in left
  use({
    "lewis6991/gitsigns.nvim",
    opt = true,
    ft = "gitcommit",
    setup = function()
      require("core.commands").gitsigns()
    end,
    config = function()
      require("configs.others").gitsigns()
    end,
  })

  -- helper indentline
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

  -- to help fast code
  use({
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("configs.autopairs")
    end,
  })

  -- faster commenr
  use({
    "numToStr/Comment.nvim",
    module = { "Comment", "Comment.api" },
    keys = { "gc", "gb" },
    config = function()
      require("configs.others").comment()
    end,
  })

  -- better scroll
  use({
    "karb94/neoscroll.nvim",
    opt = true,
    disable = true,
    module = "neoscroll",
    keys = {
      "<C-u>",
      "<C-d>",
      "<C-b>",
      "<C-f>",
      "<C-y>",
      "<C-e>",
      "zt",
      "zz",
      "zb",
      "Up",
      "Down",
      "<SrollWhellUp>",
      "<SrollWhellDown>",
    },
    config = function()
      require("configs.others").neoscroll()
    end,
  })

  -- dashboard when opening neovim
  use({
    "goolord/alpha-nvim",
    cmd = "Alpha",
    module = "alpha",
    event = "VimEnter",
    config = function()
      require("configs.alpha")
    end,
  })

  -- don't forgot ksymaps
  use({
    "folke/which-key.nvim",
    cmd = "WhichKey",
    keys = { "<leader>", "`", "'", "@", '"' },
    config = function()
      require("configs.whichkey")
    end,
  })

  -- better escape
  use({
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("configs.others").better_escape()
    end,
  })

  -- better develop neovim with lua
  use({
    "folke/neodev.nvim",
    module = "neodev",
    config = function()
      require("neodev").setup()
    end,
    ft = "lua",
  })
end)
