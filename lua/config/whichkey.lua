local status, wk = pcall(require, "which-key")
if not status then
  return
end

local setup = {
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  key_labels = {},
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "+",
  },
  popup_mappings = {
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
  },
  window = {
    border = "rounded",
    position = "bottom",
    margin = { 1, 0, 1, 0 },
    padding = { 2, 2, 2, 2 },
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
    align = "left",
  },
  ignore_missing = true,
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
  show_help = true,
  triggers = "auto",
  triggers_blacklist = {
    i = { "j", "j" },
    n = { "z", "g" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

local mappings = {
  ["a"] = { ":Alpha<cr>", "Open Alpha" },
  ["e"] = { "<cmd>NeoTreeRevealToggle<cr>", "Files Explorer, Left" },
  ["t"] = { "<cmd>NeoTreeFloatToggle<cr>", "File Explorer, Float" },
  ["r"] = { "<cmd>so<cr>", "Reload File" },
  ["x"] = { ":bdelete<cr>", "Close Buffer" },
  w = {
    name = "Save",
    w = { ":w<cr>", "Save File" },
    a = { ":wall<cr>", "Save All Files" },
    q = { ":wq<cr>", "Save & Quit" },
    f = { ":wall<cr> :qall<cr>", "Save All Files & Quit" },
  },
  q = {
    name = "Quits",
    q = { ":q<cr>", "Quit File" },
    a = { ":qall<cr>", "Quit All Files" },
    f = { ":q!<cr>", "Force Quit" },
    i = { ":qall!<cr>", "Force Quit All Files" },
  },
  f = {
    name = "Telescope",
    t = { ":Telescope<cr>", "Open Telescope" },
    f = { "<cmd>Telescope find_files <cr>", "Find Fles" },
    o = { ":Telescope oldfiles <cr>", "Recent Files" },
    b = { "<cmd>Telescope buffers<cr>", "Choose Buffers" },
    c = { ":Telescope colorscheme<cr>", "Choose Colorscheme" },
    k = { ":Telescope keymaps<cr>", "See all Keybindings" },
    d = { ":Telescope file_browser<cr>", "Find Browser" },
  },
  p = {
    name = "Packer",
    i = { ":PackerStatus<cr>", "Packer Status" },
    d = { ":PackerInstall<cr>", "Packer Installing Plugins" },
    c = { ":PackerCompile<cr>", "Packer Compile" },
    r = { ":PackerClean<cr>", "Clean Plugins" },
    s = { ":PackerSync<cr>", "Packer Sync" },
  },
  l = {
    name = "LSP",
    a = { ":Lspsaga code_action<cr>", "Code Action" },
    d = { ":Lspsaga hover_doc<cr>", "Hover Doc" },
    m = { ":Mason<cr>", "Open Mason" },
    i = { ":LspInfo<cr>", "LSP Info" },
    s = { ":LspStart<cr>", "Start LSP" },
    S = { ":LspStop<cr>", "Stop LSP" },
    f = { ":lua vim.lsp.buf.format({ timeout_ms = 2000 })<cr>", "Format Code" },
    l = { ":Lspsaga show_line_diagnostics<cr>", "Line Diagnostic" },
    c = { ":Lspsaga show_cursor_diagnostics<cr>", "Cursor Diagnostic" },
    F = { ":Lspsaga lsp_finder<cr>", "Finder" },
    r = { ":Lspsaga rename<cr>", "Rename" },
    k = { ":Lspsaga diagnostic_jump_prev<cr>", "Jump Previous" },
    j = { ":Lspsaga diagnostic_jump_next<cr>", "Jump Next" },
    o = { ":LSoutlineToggle<cr>", "Out Line Toggle" },
    n = {
      ':lua require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })<cr>',
      "Next Error",
    },
    p = {
      ':lua require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })<cr>',
      "Prev Error",
    },
  },
  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },
}

wk.setup(setup)
wk.register(mappings, opts)
