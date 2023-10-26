local Menu = require("nui.menu")
local Split = require("nui.split")

function Splitting(direction, size)
  local split = Split({
    relative = "editor",
    position = direction,
    size = size,
  })

  split:mount()

  vim.cmd("term")
end

local M = {}

M.term_exec = function()
  local menu = Menu({
    position = "50%",
    size = {
      width = 25,
      height = 8,
    },
    border = {
      style = "single",
      text = {
        top = "[Terminal]",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }, {
    lines = {
      Menu.item("Top"),
      Menu.item("Right"),
      Menu.item("Bottom"),
      Menu.item("Left"),
      Menu.separator("Commands", {
        char = "—",
      }),
      Menu.item("Node"),
      Menu.item("Live-Server"),
    },
    max_width = 20,
    keymap = {
      focus_next = { "j", "<Down>", "<Tab>" },
      focus_prev = { "k", "<Up>", "<S-Tab>" },
      close = { "<Esc>", "<C-c>", "q" },
      submit = { "<CR>", "<Space>" },
    },
    on_submit = function(item)
      if item.text == "Top" then
        Splitting("top", 10)
      end

      if item.text == "Right" then
        Splitting("right", 35)
      end

      if item.text == "Bottom" then
        Splitting("bottom", 10)
      end

      if item.text == "Left" then
        Splitting("left", 35)
      end

      if item.text == "Node" then
        vim.cmd("!node " .. vim.fn.expand("%:f"))
      end

      if item.text == "Live-Server" then
        vim.cmd("!live-server " .. vim.fn.getcwd())
      end
    end,
  })

  -- mount the component
  menu:mount()
end

return M
