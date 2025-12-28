---@type vim.lsp.ClientConfig
return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  settings = {
    json = {
      validate = { enable = true },
    },
  },
  before_init = function(_, config)
    config.settings.json.schemas = require('schemastore').json.schemas()
  end,
}
