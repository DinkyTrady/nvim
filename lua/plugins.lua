local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing Packer and Sync All Plugins")
  vim.cmd([[packadd packer.nvim]])
end

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
  use("wbthomason/packer.nvim")
  use("nvim-lua/plenary.nvim")
  use("lewis6991/impatient.nvim")
  use("goolord/alpha-nvim")
  use("akinsho/toggleterm.nvim")
  use("SmiteshP/nvim-navic")
  use("dstein64/vim-startuptime")
  use("karb94/neoscroll.nvim")

  --for fast to another file and icons
  use({ "nvim-tree/nvim-tree.lua", tag = "nightly" })

  -- lsp (language server protocol)
  use({
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "glepnir/lspsaga.nvim",
    "jose-elias-alvarez/null-ls.nvim",
  })

  --completion
  use({
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/nvim-cmp",
    "onsails/lspkind.nvim",
  })

  --snippets
  use({
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  })

  --treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "p00f/nvim-ts-rainbow",
      -- 'nvim-treesitter/nvim-treesitter-context',
    },
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
  })

  --ui and ux
  use("nvim-lualine/lualine.nvim")
  use("folke/tokyonight.nvim")
  use("lukas-reineke/indent-blankline.nvim")
  use("nvim-telescope/telescope.nvim")
  use("nvim-telescope/telescope-file-browser.nvim")
  use("nvim-tree/nvim-web-devicons")
  use("windwp/nvim-autopairs")
  use("numToStr/Comment.nvim")
  use("folke/which-key.nvim")
  use("akinsho/bufferline.nvim")
  use("NvChad/nvim-colorizer.lua")
  use("lewis6991/gitsigns.nvim")
  if packer_bootstrap then
    packer.sync()
  end
end)
