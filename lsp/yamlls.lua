---@type vim.lsp.ClientConfig
return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  settings = {
    yaml = {
      schemaStore = {
        enable = true,
      },
    },
  },
  before_init = function(_, config)
    config.settings.yaml.schemas = require('schemastore').yaml.schemas()
  end,
}
