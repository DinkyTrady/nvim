local border = {
  { "🭽", "FloatBorder" },
  { "▔", "FloatBorder" },
  { "🭾", "FloatBorder" },
  { "▕", "FloatBorder" },
  { "🭿", "FloatBorder" },
  { "▁", "FloatBorder" },
  { "🭼", "FloatBorder" },
  { "▏", "FloatBorder" },
}
-- 🭽(left-top) 🭾(top-right) 🭿(bottm-right) 🭼(bottm-left)

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  opts.max_width = opts.max_width or 54
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- local orig_util_stylize_markdown = vim.lsp.util.stylize_markdown
-- function vim.lsp.util.stylize_markdown(bufnr, contents, opts)
--   bufnr = 0 or bufnr
--   contents = contents or {}
--   opts = opts or {}
--   return orig_util_stylize_markdown(bufnr, contents, opts)
-- end

-- Diagnostic
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = "●", -- Could be '■', '▎', 'x'
    spacing = 2,
  },
  update_in_insert = true,
  severity_sort = true,
})
