local M = {}

M.comment = function()
  local comment_ok, comment = pcall(require, "Comment")
  if not comment_ok then
    return
  end

  comment.setup({
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  })
end

M.gitsigns = function()
  local status, gitsigns = pcall(require, "gitsigns")
  if not status then
    return
  end

  gitsigns.setup({
    signs = {
      add = { hl = "GitSignsAdd", text = "▊", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
      change = { hl = "GitSignsChange", text = "▊", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
      delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      changedelete = {
        hl = "GitSignsChange",
        text = "▊",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
    },
  })
end

M.devicons = function()
  local dev_icon_ok, dev = pcall(require, "nvim-web-devicons")
  if not dev_icon_ok then
    return
  end

  local material_icon_ok, material_icon = pcall(require, "nvim-material-icon")
  if not material_icon_ok then
    return
  end

  material_icon.setup({
    override = {
      json = {
        icon = "",
        color = "#cbcb41",
        cterm_color = "185",
        name = "Json",
      },
      json5 = {
        icon = "",
        color = "#cbcb41",
        cterm_color = "185",
        name = "Json5",
      },
      jsx = {
        icon = "",
        color = "#519aba",
        cterm_color = "67",
        name = "Jsx",
      },
      tsx = {
        icon = "",
        color = "#519aba",
        cterm_color = "67",
        name = "Tsx",
      },
      ts = {
        icon = " ﯤ ",
        color = "#519aba",
        cterm_color = "67",
        name = "Ts",
      },
    },
  })

  dev.setup({
    override = material_icon.get_icons(),
    default = true,
  })
end

M.snippets = function()
  local ls_ok, ls = pcall(require, "luasnip")
  if not ls_ok then
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

M.bufferline = function()
  local bufferline_ok, bufferline = pcall(require, "bufferline")
  if not bufferline_ok then
    return
  end

  bufferline.setup({
    options = {
      numbers = "ordinal",
      offsets = {
        {
          filetype = "neo-tree",
          text = "  File Explorer  ",
          highlight = "NvimTreeBufferLine",
          padding = 0,
        },
        { filetype = "" },
      },
      always_show_bufferline = false,
    },
    highlights = {
      buffer_selected = {
        italic = false,
      },
      numbers_selected = {
        italic = false,
      },
    },
  })
end

M.navic = function()
  local status, navic = pcall(require, "nvim-navic")
  if not status then
    return
  end

  navic.setup({
    icons = {
      File = " ",
      Module = " ",
      Namespace = " ",
      Package = " ",
      Class = " ",
      Method = " ",
      Property = " ",
      Field = " ",
      Constructor = " ",
      Enum = " ",
      Interface = " ",
      Function = " ",
      Variable = " ",
      Constant = " ",
      String = " ",
      Number = " ",
      Boolean = " ",
      Array = " ",
      Object = " ",
      Key = " ",
      Null = " ",
      EnumMember = " ",
      Struct = " ",
      Event = " ",
      Operator = " ",
      TypeParameter = " ",
    },
    highlight = true,
  })

  require("others.winbar").setup()
end

M.indentline = function()
  vim.opt.list = true
  vim.opt.listchars:append("eol:↴")

  local blankline_ok, blankline = pcall(require, "indent_blankline")
  if not blankline_ok then
    return
  end

  blankline.setup({
    show_current_context = true,
    show_current_context_start = true,
    show_end_of_line = true,
  })
end

M.neoscroll = function()
  local status, neoscroll = pcall(require, "neoscroll")
  if not status then
    return
  end

  neoscroll.setup({
    mappings = {
      "<C-u>",
      "<C-d>",
      "<C-b>",
      "<C-f>",
      "<C-y>",
      "<C-e>",
      "zt",
      "zz",
      "zb",
      "<Up>",
      "<Down>",
      "<ScrollWheelUp>",
      "<ScrollWheelDown>",
    },
  })
end

M.better_escape = function()
  local status, bs = pcall(require, "better_escape")
  if not status then
    return
  end

  bs.setup({ clear_empty_lines = true, mapping = { "jk", "jj", "kj", "kk" } })
end

return M
