local ts_js_config = function()
  return {
    updateImportsOnFileMove = { enabled = 'always' },
    suggest = {
      completeFunctionCalls = true,
      completeJSDocs = true,
    },
    inlayHints = {
      enumMemberValues = { enabled = true },
      functionLikeReturnTypes = { enabled = true },
      parameterNames = { enabled = 'all' },
      parameterTypes = { enabled = true },
      propertyDeclarationTypes = { enabled = true },
      variableTypes = { enabled = true },
    },
  }
end

---@type vim.lsp.ClientConfig
---@diagnostic disable-next-line: missing-fields
return {
  cmd = { 'vtsls', '--stdio' },
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        -- maxInlayHintLength = 30,
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    ['js/ts'] = {
      implicitProjectConfig = {
        checkJs = true,
      },
    },
    javascript = ts_js_config(),
    typescript = ts_js_config(),
  },
}
