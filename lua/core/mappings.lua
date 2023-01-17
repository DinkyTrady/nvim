vim.g.mapleader = " "
vim.g.maplocalleader = " "

local general_mappings = {
  i = {
    ["<C-a>"] = { "<ESC><CMD>%y+<CR>gi", "Copy Whole lines" },
    ["<C-r>"] = { "<ESC><C-r>gi", "Redo File" },
    ["<C-u>"] = { "<ESC>ugi", "Undo File" },
    ["<C-p>"] = { "<ESC>Pgi", "Paste" },
    ["<C-f>"] = { "<ESC>zzgi", "Focus" },
    ["<C-b>"] = { "<ESC>zz<C-u>gi", "Go Up" },
    ["<C-d>"] = { "<ESC>zz<C-d>gi", "Go Down" },
    ["<C-x>"] = { "<ESC>ddgi", "Delete Line" },
    ["<C-h>"] = { "<Left>", "Left" },
    ["<C-j>"] = { "<Down>", "Down" },
    ["<C-k>"] = { "<Up>", "Up" },
    ["<C-l>"] = { "<Right>", "Right" },
    ["<A-H>"] = { "<C-Left>", "b -normal mode" },
    ["<A-L>"] = { "<C-Right>", "w -normal mode" },
    ["<C-n>"] = { "<HOME>", "Go to First Line" },
    ["<C-e>"] = { "<END>", "Go to End Line" },
    ["<A-k>"] = { "<ESC>v:m .-2<CR>==gi", "Move Line to Up" },
    ["<A-j>"] = { "<ESC>v:m .+1<CR>==gi", "Move Line to Down" },
  },
  s = {
    ["jj"] = { "<ESC>", "Go to Normal" },
    ["jk"] = { "<ESC>", "Go to Normal" },
  },
  n = {
    ["<C-t>h"] = { "<CMD>sp | resize -12 | ter<CR>", "Split Term" },
    ["<C-t>v"] = { "<CMD>vs | vertical resize -5 | ter<CR>", "VertSplit Term" },
    ["<C-t>t"] = { "<CMD>term<CR>", "New Buffer Term" },
    ["<C-t>n"] = { [[:lua vim.api.nvim_command(":!node " .. vim.fn.expand("%:f"))<CR>]], "node js" },
    ["<C-a>"] = { "<CMD>%y+<CR>", "Copy All Lines" },
    ["<C-Up>"] = { "<CMD>resize -2<CR>", "Resize Up" },
    ["<C-Down>"] = { "<CMD>resize +2<CR>", "Resize Down" },
    ["<C-Right>"] = { "<CMD>vertical resize -2<CR>", "Resize to Right" },
    ["<C-Left>"] = { "<CMD>vertical resize +2<CR>", "Resize to Left" },
    ["<Tab>"] = { "<CMD>bnext<CR>", "Next Buffer" },
    ["<BS>"] = { "<CMD>bprev<CR>", "Prev Buffer" },
    ["<C-h>"] = { "<C-w>h", "Go to Left Window" },
    ["<C-j>"] = { "<C-w>j", "Go to Bottom Window" },
    ["<C-k>"] = { "<C-w>k", "Go to Top Window" },
    ["<C-l>"] = { "<C-w>l", "Go to Right Window" },
    ["n"] = { "nzz", "Next Search & Focus" },
    ["N"] = { "Nzz", "Prev Search & Focus" },
    ["X"] = { '"_x', "Delete Without Copy" },
    ["dD"] = { '"_dd', "Delete Line Without Copy" },
    ["<ScrollWheelDown>"] = { "<C-e><C-e><C-e><C-e><C-e>", "Down" },
    ["<ScrollWheelUp>"] = { "<C-y><C-y><C-y><C-y><C-y>", "Up" },
    -- smooth scrolling
    ["<C-d>"] = { "<C-d>zz" },
    ["<C-f>"] = { "<C-f>zz" },
    ["<C-u>"] = { "<C-u>zz" },
    ["<C-b>"] = { "<C-b>zz" },
  },
  v = {
    ["jk"] = { "<ESC>", "Normal Mode" },
    ["<A-Up>"] = { "<CMD>m .-2<CR>==gv", "Move Up" },
    ["<A-Down>"] = { "<CMD>m .+1<CR>==gv", "Move Down" },
    ["X"] = { '"_x', "Delete no Copy" },
    ["<"] = { "<gv", "Move Left" },
    [">"] = { ">gv", "Move Right" },
  },
  t = {
    ["<C-h>"] = { [[<C-\><C-n><C-W>h]], "Go Left Window" },
    ["<C-j>"] = { [[<C-\><C-n><C-W>j]], "Go bottom Window" },
    ["<C-k>"] = { [[<C-\><C-n><C-W>k]], "Go Up Window" },
    ["<C-l>"] = { [[<C-\><C-n><C-W>l]], "Go Right Window" },
    ["<C-Tab>"] = { [[<C-\><C-n><CMD>bnext<CR>]], "Next Buffer" },
    ["<C-BS>"] = { [[<C-\><C-n><CMD>bprev<CR>]], "Prev Buffer" },
    ["<C-t>"] = { [[<C-\><C-n><CMD>bd!<CR>]], "Quit Term" },
    ["<C-q>"] = { [[<C-\><C-n>]], "Normal mode" },
    ["<A-t>h"] = { [[<C-\><C-n>:sp | resize -10 | term<CR>]], "New Split Term" },
    ["<A-t>v"] = { [[<C-\><C-n>:vs | resize -5 | term<CR>]], "New VertSplit Term" },
  },
}

local set_maps = function(bruh)
  for mode, mode_value in pairs(bruh) do
    for keymap, keymap_value in pairs(mode_value) do
      local opts = { noremap = true, silent = true, nowait = true } or {}
      opts.desc = keymap_value[2]
      opts.expr = keymap_value.opts
      vim.api.nvim_set_keymap(mode, keymap, keymap_value[1], opts)
    end
  end
end

set_maps(general_mappings)

-- regsiter mappings in whichkey

local register = {
  whichkey = {
    a = { ":Alpha<CR>", "Open Dashboard" },
    e = { ":NeoTreeRevealToggle<CR>", "Focus neo-tree" },
    t = { ":NeoTreeFloatToggle<CR>", "Float neo-tree" },
    x = { ":bdelete!<CR>", "Close Buffer" },
    c = { ":ColorizerToggle<CR>", "See Colors" },
    r = { ":so<CR>", "Reload File" },
    w = {
      name = "Save",
      w = { ":w<cr>", "Save File" },
      a = { ":wall<cr>", "Save All Files" },
      q = { ":wq<cr>", "Save & Quit" },
      f = { ":wa | qall<cr>", "Save All Files & Quit" },
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
      m = { ":Telescope keymaps<cr>", "See Mappings" },
      d = { ":Telescope file_browser<cr>", "Find Browser" },
      p = { ":Telescope projects<CR>", "Find Projects" },
    },
    p = {
      name = "Packer",
      S = { ":PackerStatus<cr>", "Packer Status" },
      i = { ":PackerInstall<cr>", "Packer Installing Plugins" },
      c = { ":PackerCompile<cr>", "Packer Compile" },
      C = { ":PackerClean<CR>", "Clean Plugins" },
      s = { ":PackerSync<cr>", "Packer Sync" },
    },
    l = {
      name = "LSP",
      a = { ":Lspsaga code_action<cr>", "Code Action" },
      d = { ":lua vim.lsp.buf.hover()<cr>", "Hover Doc" },
      D = { ":Lspsaga peek_definition<CR>", "Float Definition" },
      m = { ":Mason<cr>", "Open Mason" },
      i = { ":LspInfo<cr>", "LSP Info" },
      s = { ":LspStart<cr>", "Start LSP" },
      S = { ":LspStop<cr>", "Stop LSP" },
      f = { ":lua vim.lsp.buf.format({ timeout_ms = 2000 })<cr>", "Format Code" },
      l = { ":Lspsaga show_line_diagnostics<cr>", "Line Diagnostic" },
      c = { ":Lspsaga show_cursor_diagnostics<cr>", "Cursor Diagnostic" },
      F = { ":Lspsaga lsp_finder<cr>", "Finder" },
      r = { ":lua require'others.rename'.open()<cr>", "Rename" },
      k = { ":Lspsaga diagnostic_jump_prev<cr>", "Jump Previous" },
      j = { ":Lspsaga diagnostic_jump_next<cr>", "Jump Next" },
      o = { ":Lspsaga outline<cr>", "Out Line Toggle" },
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
  },
}

return register
