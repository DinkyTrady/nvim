local status, alpha = pcall(require, 'alpha')
if not status then
  return
end

local db = require("alpha.themes.dashboard")

db.section.header.val = {
    "                                                         ",
    "    ███    ██ ███████  ██████  ██    ██ ██ ███    ███    ",
    "    ████   ██ ██      ██    ██ ██    ██ ██ ████  ████    ",
    "    ██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██    ",
    "    ██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██    ",
    "    ██   ████ ███████  ██████    ████   ██ ██      ██    ",
    "                                                         ",
    "                                                         ",
}

db.section.buttons.val = {
	db.button("f", "  Find file", ":Telescope find_files <CR>"),
  db.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
	db.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
  db.button("k", "  Mapping", ":Telescope keymaps <CR>"),
  db.button("e", "  Explore Tree", ":NvimTreeToggle <CR>"),
	db.button("o", "  Configuration", ":e $MYVIMRC <CR>"),
	db.button("q", "  Quit Neovim", ":q<CR>"),
}

db.section.footer.val = require 'alpha.fortune'()

db.section.footer.opts.hl = "AlphaFooter"
db.section.header.opts.hl = "AlphaHeader"
db.section.buttons.opts.hl = "AlphaButtons"

db.opts.opts.noautocmd = true
alpha.setup(db.opts)
