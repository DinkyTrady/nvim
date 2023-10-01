local M = {}

M.config = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  init = function()
    require("core.commands").lazyload("indent-blankline.nvim")
  end,
  config = function()
    require("configs.indent-blankline").setup()
  end,
}

function M.setup()
  local ibl_ok, ibl = pcall(require, "ibl")
  if not ibl_ok then
    return
  end

  ibl.setup({
    scope = {
      enabled = true,
      highlight = { "Conditional" },
      char = { "▎" },
    },
    indent = {
      char = "⎜",
    },
    show_current_context = true,
    show_current_context_start = true,
    show_end_of_line = true,
  })
  local hooks = require("ibl.hooks")
  hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

return M
