return {
	    "nvim-telescope/telescope.nvim",
	    cmd = "Telescope",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-lua/plenary.nvim"
    },
    keys = {
      { ";w", ":Telescope live_grep<Cr>",desc = "Grep (root dir)" },
      -- find
      { ";d", "<Cmd>Telescope file_browser<Cr>", desc = "File Browser" },
      { ";b", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { ";f", "<Cmd>Telescope fd<Cr>",desc = "Find Files (root dir)" },
      { ";F", "<Cmd>Telescope fd hidden=true<Cr>", desc = "Find Files (cwd)" },
      { ";r", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      -- search
      { ";E", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { ";e", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      { ";h", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { ";m", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    },
    config = function()
      local tls = require("telescope")
      tls.setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_strategy = "flex",
          layout_config = { prompt_position = "top" },
	  find_command = { "fd" },
          hidden = true,
          mappings = {
            n = {
              ["q"] = require("telescope.actions").close,
            },
          },
        },
        extensions = {
          file_browser = {
            initial_mode = "normal",
            hidden = true,
            preview = false,
            mappings = {
              n = {
                ["h"] = tls.extensions.file_browser.actions.goto_parent_dir,
                ["l"] = require("telescope.actions").select_default,
              },
            },
          },
        },
      })

      tls.load_extension("file_browser")
    end,

}
