return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = 'ConformInfo',
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat Buffer',
    },
  },
  ---@module 'conform'
  ---@type conform.setupOpts
  opts = {
    formatters = {
      kulala = {
        command = 'kulala-fmt',
        args = { 'format', '$FILENAME' },
        stdin = false,
      },
    },
    notify_on_error = true,
    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      typescript = { 'prettier' },
      html = { 'prettier' },
      markdown = { 'prettier' },
      css = { 'prettier' },
      javascript = { 'prettier' },
      jsonc = { 'prettier' },
      http = { 'kulala-fmt' },
      php = { 'php_cs_fixer' },
    },
  },
}
