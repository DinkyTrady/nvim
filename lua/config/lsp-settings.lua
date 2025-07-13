local border = {
  { "┍", "FloatBorder" },
  { "━", "FloatBorder" },
  { "┑", "FloatBorder" },
  { "│", "FloatBorder" },
  { "┙", "FloatBorder" },
  { "━", "FloatBorder" },
  { "┕", "FloatBorder" },
  { "│", "FloatBorder" },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  opts.max_width = opts.max_width or 55
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Diagnostic
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = false,
  -- virtual_text = {
  -- 	enable = false,
  -- 	prefix = " ", -- Could be '■', '▎', 'x'
  -- 	spacing = 2,
  -- },
  update_in_insert = true,
  severity_sort = false,
})
