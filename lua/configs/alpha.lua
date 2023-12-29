local M = {}

M.config = {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    require("configs.alpha").setup()
  end,
}

function M.setup()
  local status, alpha = pcall(require, "alpha")
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
    db.button("f", "󰱽  Find files", ":Telescope find_files<CR>"),
    db.button("r", "󱀸  Recently files", ":Telescope oldfiles<CR>"),
    db.button("n", "  New file", ":ene <BAR> startinsert<CR>"),
    db.button("m", "󰥻  Mappings", ":Telescope keymaps<CR>"),
    db.button("e", "  Explore Tree", ":Neotree toggle<CR>"),
    db.button("d", "  Find Directory", ":Telescope file_browser<CR>"),
    db.button("p", "  Find Projects", ":Telescope projects<CR>"),
    db.button("s", "   Session Restore", ":lua require('persistence').load({ last = true })<cr>"),
    db.button("c", "  Configuration", ":e $MYVIMRC<CR>"),
    db.button("q", "󰅙  Quit Neovim", ":q<CR>"),
  }

  db.section.footer.opts.hl = "AlphaFooter"
  db.section.header.opts.hl = "AlphaHeader"
  db.section.buttons.opts.hl = "AlphaButtons"

  db.opts.opts.noautocmd = true
  alpha.setup(db.opts)

  vim.api.nvim_create_autocmd("User", {
    once = true,
    pattern = "LazyVimStarted",
    callback = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      db.section.footer.val = " Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
      pcall(vim.cmd.AlphaRedraw)
    end,
  })
end

return M
