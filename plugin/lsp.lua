
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  callback = function()
    vim.lsp.enable {
      'lua_ls',
      'vtsls',
      'clangd',
      'html',
      'basedpyright',
      'ruff',
      'djlsp',
      'emmet_language_server',
      'tinymist'
      -- 'dartls'
    }

    vim.lsp.config('emmet_language_server', {
      filetypes = { 'html', 'htmldjango' }
    })
    vim.lsp.config('html', {
      filetypes = { 'html', 'htmldjango' }
    })
    vim.lsp.config('*', {
      on_attach = require'lsp-settings'.on_attach,
    })
  end,
})
