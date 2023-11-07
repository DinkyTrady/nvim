local M = {}

M.config = {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    require("configs.luasnip").setup()
  end,
}

function M.setup()
  local status, ls = pcall(require, "luasnip")
  if not status then
    return
  end

  require("luasnip.loaders.from_vscode").lazy_load()

  local parse = ls.parser.parse_snippet
  local types = require("luasnip.util.types")

  ls.config.setup({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_base_prio = 300,
    ext_prio_increase = 2,
    ship_env = {
      types = types,
      parse = parse,
    },
  })
end

return M
