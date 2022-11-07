local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
  'git',
  'clone',
  '--depth',
  '1',
  'https://github.com/wbthomason/packer.nvim',
  install_path
  }
  print 'installing plugins and Sync it'
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, 'packer')
if not status then
  return
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  --for fast to another file and icons
  use {'nvim-tree/nvim-tree.lua', tag = 'nightly'}
  -- lsp (language server protocol)
  use {
    'williamboman/mason.nvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'williamboman/mason-lspconfig.nvim'
  }
  --completion
  use {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/nvim-cmp',
    'onsails/lspkind.nvim'
  }
  --snippets
  use {
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets'
  }
  --treesitter
  use {'nvim-treesitter/nvim-treesitter', run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    'windwp/nvim-ts-autotag',
    'p00f/nvim-ts-rainbow',
    'JoosepAlviste/nvim-ts-context-commentstring',
    'nvim-treesitter/nvim-treesitter-context'
  }
  --ui and ux
  use 'nvim-lualine/lualine.nvim'
  use 'folke/tokyonight.nvim'
  use "lukas-reineke/indent-blankline.nvim"
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-tree/nvim-web-devicons'
  use 'karb94/neoscroll.nvim'
  use 'windwp/nvim-autopairs'
  use 'numToStr/Comment.nvim'
  use 'folke/which-key.nvim'
  use 'akinsho/bufferline.nvim'
  if packer_bootstrap then
    require('packer').sync()
  end
end)
