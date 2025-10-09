---@type vim.lsp.Config
return {
  settings = {
    basedpyright = {
      analysis = {
        stubPath = vim.fs.joinpath(vim.fn.stdpath('data'), 'site', 'pack', 'core', 'opt', 'python-type-stubs'),
        typeCheckingMode = 'off',
        diagnosticMode = 'OpenFilesOnly'
      }
    }
  }
}
