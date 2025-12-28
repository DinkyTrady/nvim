return {
  'nvim-treesitter/nvim-treesitter',
  event = 'BufReadPre',
  build = ':TSUpdate',
  dependencies = {
    'windwp/nvim-ts-autotag',
  },
  ---@module 'nvim-treesitter'
  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    auto_install = true,
    ensure_installed = {
      'lua',
      'vim',
      'markdown',
      'markdown_inline',
      'yaml',
      'json',
      'html',
      'css',
      'javascript',
      'jsdoc',
      'tsx',
    },
    highlight = { enable = true },
    indent = { enable = true },
    autotag = {
      enable = true,
      disable = { 'xml', 'markdown' },
      filetypes = {
        'html',
        'javascript',
        'javascriptreact',
        'svelte',
        'typescript',
        'typescriptreact',
        'vue',
      },
    },
  },
  config = function(_, opts)
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'v:lua.vim.treesitter.fodlexpr()'
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    vim.opt.fillchars = { fold = ' ', foldopen = '', foldclose = '>', foldsep = ' ' }
    vim.opt.foldcolumn = '0'
    vim.opt.foldtext = ''

    require('nvim-treesitter.configs').setup(opts)
  end,
}
