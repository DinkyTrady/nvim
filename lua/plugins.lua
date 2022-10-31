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
  print 'installing Pakcer and Sync it'
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
  use 'folke/tokyonight.nvim'
  use 'navarasu/onedark.nvim'
  use 'windwp/nvim-autopairs'
  use 'numToStr/Comment.nvim'
  use "lukas-reineke/indent-blankline.nvim"
  use 'folke/which-key.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use 'karb94/neoscroll.nvim'
  use {'nvim-telescope/telescope.nvim', tag = '0.1.0'}
  use ('akinsho/bufferline.nvim', {tag = 'v.3*'})
  --for fast to another file and icons
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    tag = 'nightly'
  }
  use {
    'williamboman/mason.nvim',
    'neovim/nvim-lspconfig',
    'williamboman/mason-lspconfig.nvim'
  }
  --complation
  use {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
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
  use {
    {'nvim-treesitter/nvim-treesitter', run = function() require('nvim-treesitter.install').update({with_sync = true}) end},
    'windwp/nvim-ts-autotag',
    'p00f/nvim-ts-rainbow',
    'JoosepAlviste/nvim-ts-context-commentstring',
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-textobjects'
  }
  --ui
  use 'nvim-lualine/lualine.nvim'
  if packer_bootstrap then
    require('packer').sync()
  end
end)
