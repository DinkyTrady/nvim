local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path
    })
    print('installing packer and configure it.....')
    vim.cmd [[packadd packer.nvim]]
    vim.cmd "bw | silent! MasonInstallAll" -- close packer window
    require("packer").loader "nvim-treesitter"
    return true
  end
  return false
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})


local packer_bootstrap = ensure_packer()

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  --LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  --CMP
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'
  use 'onsails/lspkind-nvim'
  --Good exoerience
  use 'numToStr/Comment.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use 'nvim-lualine/lualine.nvim'
  use {'akinsho/bufferline.nvim', tag = "v3.*"}
  --Syntax highlighting && colorscheme
  use {
       'nvim-treesitter/nvim-treesitter',
       run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use 'folke/tokyonight.nvim'
  if packer_bootstrap then
    require('packer').sync()
  end
end)
