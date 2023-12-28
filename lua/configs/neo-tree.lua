local M = {}

M.config = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  config = function()
    require("configs.neo-tree").setup()
  end,
  dependencies = { "MunifTanjim/nui.nvim" },
}

function M.setup()
  local status, tree = pcall(require, "neo-tree")
  if not status then
    return
  end

  local options = {
    source_selector = {
      winbar = true,
      sources = {
        { source = "filesystem", display_name = "  Files" },
        { source = "buffers", display_name = " 󱌣 Buffers" },
        { source = "git_status", display_name = " 󰊢 Git" },
      },
    },
    popup_border_style = "single",
    default_component_configs = {
      icon = {
        folder_empty = " ",
      },
      git_status = {
        symbols = {
          -- Change type
          added = " ", -- or "✚",
          modified = "", -- or "",
          deleted = " ", -- this can only be used in the git_status source
        },
      },
    },
    window = {
      width = 30,
      mappings = {
        -- disable default mappings
        ["<space>"] = "",
        ["<bs>"] = "",
        -- custom mappings
        [","] = {
          "toggle_node",
          nowait = true,
        },
        ["-"] = "navigate_up",
        ["p"] = "paste_from_clipboard",
      },
    },
    nesting_rules = {},
    filesystem = {
      filtered_items = {
        visible = true, -- when true, they will just be displayed differently than normal items
        hide_by_name = {
          "node_modules",
        },
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = true,
      },
      window = {
        mappings = {
          -- disable mappings
          ["[g"] = "",
          ["]g"] = "",
          -- custom mappings
          ["gp"] = "prev_git_modified",
          ["gn"] = "next_git_modified",
        },
      },
    },
    git_status = {
      window = {
        mappings = {
          -- disable mappings
          ["-"] = "",
          ["gg"] = "",
          --custom mappings
          ["cp"] = "git_commit_and_push",
        },
      },
    },
  }

  tree.setup(options)
end

return M
