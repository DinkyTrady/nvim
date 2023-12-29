return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  opts = {
    source_selector = {
      winbar = true,
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
  },
}
