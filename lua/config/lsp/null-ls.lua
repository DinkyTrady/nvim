local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

local diagnostic = null_ls.builtins.diagnostics
local format = null_ls.builtins.formatting
local action = null_ls.builtins.code_actions

null_ls.setup({
  debug = true,
  sources = {
    action.eslint_d,
    diagnostic.eslint_d.with({
      diagnostics_format = "[eslint] #{m}\n(#{c})",
    }),
    format.prettierd,
    -- format.eslint_d,
    format.stylua,
  },
})
