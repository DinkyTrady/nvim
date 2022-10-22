require('nvim-tree').setup ({
  sort_by = "case_sensitive",
  view = {
    number = true,
    width = 30,
    adaptive_size = false, 
    hide_root_folder = true,
    side = "left",  
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = { 
    group_empty = true,
    indent_width = 2,
      indent_markers = {
        enable = true,
        inline_arrows = true,
        icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    icons = { 
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  }, 
  filters = {
      dotfiles = false,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    debounce_delay = 50,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
})
