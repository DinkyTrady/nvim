local status, tree = pcall(require, "neo-tree")
if not status then
  return
end

tree.setup({
  source_selector = {
    winbar = true,
    -- statusline = true,
  },
  popup_border_style = "rounded",
  default_component_configs = {
    icon = {
      folder_empty = "",
    },
    git_status = {
      symbols = {
        -- Change type
        added = " ", -- or "✚", but this is redundant info if you use git_status_colors on the name
        modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
        deleted = " ", -- this can only be used in the git_status source
      },
    },
  },
  window = {
    width = 35,
    mappings = {
      -- disable default mappings
      ["<space>"] = "",
      ["<"] = "",
      [">"] = "",
      ["<bs>"] = "",
      -- custom mappings
      [","] = {
        "toggle_node",
        nowait = true, -- disable `nowait` if you have existing combos starting with this char that you want to use
      },
      ["-"] = "navigate_up",
      ["p"] = "paste_from_clipboard",
      ["("] = "prev_source",
      [")"] = "next_source",
    },
  },
  nesting_rules = {},
  filesystem = {
    filtered_items = {
      visible = true, -- when true, they will just be displayed differently than normal items
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_hidden = true, -- only works on Windows for hidden files/directories
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
})
