--nvim-treesitter-setup↴
require'nvim-treesitter.configs'.setup{
  ensure_installed = { 'lua', 'javascript', 'html', 'css' },
  sync_install = true,
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  }
}
