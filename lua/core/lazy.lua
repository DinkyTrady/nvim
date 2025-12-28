-- stylua: ignore
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", "--depth=1",
    lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require('lazy').setup {
  ---@type LazySpec
  spec = {
    { import = 'plugins' },
    { import = 'plugins.lang' },
  },
  defaults = {
    lazy = true,
    version = false, -- always use the latest git commit
  },
  install = { colorscheme = { 'catppuccin', 'habamax' } },
  checker = { enabled = false }, -- disable auto check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tutor',
        'zipPlugin',
        '2html_plugin',
        'getscript',
        'getscriptPlugin',
        'gzip',
        'logipat',
        'netrw',
        'netrwSettings',
        'netrwFileHandlers',
        'matchit',
        'tar',
        'rrhelper',
        'spellfile_plugin',
        'vimball',
        'vimballPlugin',
        'zip',
        'rplugin',
        'syntax',
        'synmenu',
        'optwin',
        -- "compiler",
        'bugreport',
        'ftplugin',
      },
    },
  },
}
