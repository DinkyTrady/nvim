local o = vim.opt --make vim options eazier with variable

local settings = {
	--settingup options
	encoding = "UTF-8",
	numberwidth = 2,
	number = true,
	relativenumber = true, -- set number in the left to relative
	cursorline = true, -- set to highligh the cursorline now
	tabstop = 2,
	shiftwidth = 2,
	expandtab = true,
	autoindent = true,
	hlsearch = true,
	ignorecase = true,
	smartcase = true,
	swapfile = false,
	termguicolors = true,
	clipboard = "unnamedplus",
	mouse = "a",
	showmode = false,
	laststatus = 3,
	showtabline = 0, --Disable tabline
	timeoutlen = 400,
	updatetime = 300,
	ruler = false,
	pumheight = 15,
	scrolloff = 5,
	sidescrolloff = 5,
	signcolumn = "yes",
	splitbelow = true,
	splitright = true,
	undofile = true,
	undodir = vim.fn.stdpath("cache") .. "/undofile",
	writebackup = false,
	wrap = false,
	lazyredraw = true,
}
o.shortmess:append("sI")
o.whichwrap:append("<,>,[,],h,l")
o.fillchars = { eob = " " }
o.completeopt = { "menuone", "noselect" }

for name, value in pairs(settings) do
	vim.api.nvim_set_option(name, value)
end
