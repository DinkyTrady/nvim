---@type vim.lsp.ClientConfig
---@diagnostic disable-next-line: missing-fields
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  settings = {
    Lua = {
      hint = {
        enable = true,
        arrayIndex = 'Disable', -- disable hint for array/object
      },
      workspace = {
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}
