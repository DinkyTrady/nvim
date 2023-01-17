local cmd = vim.api.nvim_command

local autocmds = {
  packer = {
    ["BufWritePost"] = {
      "plugins.lua",
      function()
        cmd("source <afile> | PackerSync")
      end,
    },
  },
  terminal_job = {
    ["TermOpen"] = {
      "*",
      function()
        cmd("startinsert | setlocal listchars= nonumber norelativenumber")
      end,
    },
    ["BufEnter"] = {
      "term://*",
      function()
        cmd("startinsert")
      end,
    },
  },
  restore_cursor = {
    ["BufRead"] = {
      "*",
      function()
        cmd([[call setpos(".", getpos("'\""))]])
      end,
    },
  },
  resize_windows_proportionally = {
    ["VimResized"] = {
      "*",
      function()
        cmd(":wincmd=")
      end,
    },
  },
  lua_highlight = {
    ["TextYankPost"] = {
      "*",
      function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = "100" })
      end,
    },
  },
  quit_with_q = {
    ["FileType"] = {
      {
        "help",
        "startuptime",
        "telescope",
        "neo-tree",
        "neo-tree-popup",
        "lspsagacodeaction",
        "lspsagafinder",
        "sagarename",
        "packer",
        "mason",
        "lspinfo",
        "null-ls-info",
        "tsplayground",
        "noice",
        "notify",
      },
      function()
        vim.api.nvim_buf_set_keymap(0, "n", "q", ":q!<CR>", { silent = true, noremap = true })
      end,
    },
  },
  chechk_html = {
    ["FileType"] = {
      "*.html",
      function()
        vim.opt.wrap = true
      end,
    },
  },
}

local augroups = function(group)
  for group_name, definition in pairs(group) do
    vim.api.nvim_create_augroup(group_name, { clear = true })
    for key, value in pairs(definition) do
      vim.api.nvim_create_autocmd(key, {
        group = group_name,
        pattern = value[1],
        callback = value[2],
      })
    end
  end
end

augroups(autocmds)
