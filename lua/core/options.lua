local o = vim.opt --make vim options eazier with variable

--settingup options
o.encoding = "UTF-8"
o.numberwidth = 2
-- o.number = true
o.relativenumber = true -- set number in the left to relative
o.cursorline = true -- set to highligh the cursorline now
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.autoindent = true
o.wrap = true
o.hlsearch = true
o.ignorecase = true
o.smartcase = true
o.termguicolors = true
o.clipboard = "unnamedplus"
o.mouse = "a"
o.showmode = false
o.laststatus = 3
-- o.showtabline = 2
o.timeoutlen = 600
o.updatetime = 300
o.completeopt = { "menuone", "noselect", "noinsert", "menu" }
o.scrolloff = 5
o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.undofile = true
o.undodir = vim.fn.stdpath("cache") .. "/undofile"
o.swapfile = false
o.writebackup = false
o.fillchars = { eob = " " } -- The icon [ ~ ] in end of buffer will not showwed
o.shortmess:append("sI")
-- o.foldmethod = "expr"
-- o.foldexpr = "nvim_treesitter#foldexpr()"
-- o.foldlevel = 20
-- o.wrap = false
