local Util = require("lazyvim.util")
return {
  {
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
          [";"] = {
            "toggle_node",
            nowait = true,
          },
          ["-"] = "navigate_up",
          ["p"] = "paste_from_clipboard",
        },
      },
      default_component_configs = {
        icon = {
          default = "󰡯 ",
        },
      },
      filesystem = {
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
          hide_by_name = {
            "node_modules",
            ".git",
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
  },
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    event = "LazyFile",
    init = function()
      vim.g.navic_silence = true
      require("lazyvim.util").lsp.on_attach(function(client, buffer)
        if client.supports_method("textDocument/documentSymbol") then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      _G.Winbar = {}

      local fn = vim.fn
      vim.api.nvim_set_hl(0, "edited", { fg = "#9ece6a" })

      local sep = function()
        ---@diagnostic disable-next-line: deprecated
        if require("nvim-navic").get_location() ~= "" then
          return "%#NavicSeparator#" .. " > " .. "%*"
        end

        return ""
      end

      local fileName = function()
        if vim.bo.filetype ~= "alpha" then
          return "%#NavicText#" .. fn.expand("%:t")
        end

        return ""
      end

      local function modified()
        if vim.bo.modified then
          return "%#edited#" .. " ●" .. "%*"
        elseif vim.bo.modifiable == false or vim.bo.readonly == true then
          return " "
        end

        return ""
      end

      _G.Winbar.setup = function()
        return table.concat({
          " ",
          fileName(),
          modified(),
          sep(),
          require("nvim-navic").get_location(),
        })
      end

      vim.opt.winbar = "%{%v:lua.Winbar.setup()%}"

      return {
        click = true,
        highlight = true,
        depth_limit = 5,
        icons = require("lazyvim.config").icons.kinds,
        lazy_update_context = true,
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
    },
    keys = {
      { ";w", Util.pick("live_grep"), desc = "Grep (root dir)" },
      -- find
      { ";d", "<Cmd>Telescope file_browser<Cr>", desc = "File Browser" },
      { ";b", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { ";c", Util.pick.config_files(), desc = "Find Config File" },
      { ";f", Util.pick("files", { find_command = { "fd" } }), desc = "Find Files (root dir)" },
      { ";F", Util.pick("files", { find_command = { "fd" }, cwd = false, hidden = true }), desc = "Find Files (cwd)" },
      { ";r", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { ";R", Util.pick("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
      -- search
      { ";E", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { ";e", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      { ";W", Util.pick("live_grep", { cwd = false, hidden = true }), desc = "Grep (cwd)" },
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
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
      },
      current_line_blame_formatter = "   <author>, <author_time:%c> - <summary>",
    },
  },
}
