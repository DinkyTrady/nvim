local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

local diagnostic = null_ls.builtins.diagnostics
local format = null_ls.builtins.formatting
-- local action = null_ls.builtins.code_actions
local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

null_ls.setup({
  debug = true,
  sources = {
    -- action.eslint,
    -- diagnostic.clang_check.with({
    --   diagnostics_format = "[check] #{m}\n(#{c})",
    -- }),
    -- diagnostic.eslint.with({
    --   diagnostics_format = "[eslint] #{m}\n(#{c})",
    -- }),
    -- format.prettier,
    -- format.clang_format,
    -- format.eslint_d,
    -- format.stylua,
  },
  -- on_attach = function(client, bufnr)
  --   if client.supports_method("textDocument/formatting") then
  --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       group = augroup,
  --       buffer = bufnr,
  --       callback = function()
  --         -- on 0.7, you should use vim.lsp.buf.formatting_sync() instead
  --         vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 1500 })
  --       end,
  --     })
  --   end
  -- end,
})
