--Variavbles
local o = vim.opt
local map = vim.keymap.set

--options
o.softtabstop = 2
o.tabstop = 2
o.encoding = "utf-8"
o.expandtab = true
o.shiftwidth = 2
o.number = true
o.termguicolors = true
o.cursorline = true
o.laststatus = 3
o.showmode = false
o.title = true
o.clipboard = "unnamedplus"
o.smartindent = true
o.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"
o.numberwidth = 2
o.ruler = false
o.shortmess:append "sI"
o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.updatetime = 250
o.whichwrap:append "<>[]hl"

--Disable default plugins of vim
local defaultplugs = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}
for _, plugin in pairs(defaultplugs) do
  vim.g["loaded_" .. plugin] = 1
end

--mappings
--change <leader> to 'space'. Please do not make mappings with <leader> in insert mode
vim.g.mapleader = " "
vim.g.maplocalheader = " "

--set mapping
local map = vim.keymap.set

--open nvim-tree with 'space + t'
map('n', '<leader>t', ':NvimTreeToggle<CR>')

--For save click 'space + w', save and quit click 'wq', quit neovim click 'space + q', to force quit click 'fq' in normal mode
map('n', '<leader>w', ':w<CR>')
map('n', 'wq', ':wq<CR>')
map('n', '<leader>q', ':q<CR>')
map('n', 'fq', ':q!<CR>')

--to reset neovim click 'space + s'
map('n', '<leader>s', ':so<CR>')

--To another tab
--only bufferlines
map('n', '<C-Right>', ':BufferLineCycleNext')
map('n', '<C-Left>', ':BufferLineCycleLeft')
--Default tab
map('n', '<leader>Right', ':tabnext')
map('n', '<leader>Left', ':tableft')
