local cmd = vim.api.nvim_command
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- for autocmomands
local autocmds = {
  md_maps = {
    ["FileType"] = {
      "markdown",
      function()
        vim.api.nvim_buf_set_keymap(0, "n", "mt", ":MarkdownPreviewToggle<Cr>", { silent = true, noremap = true })
      end,
    },
  },
  liveserver = {
    ["FileType"] = {
      { "html", "css", "javascript" },
      function()
        vim.api.nvim_buf_set_keymap(0, "n", "mls", ":TermExec cmd=live-server<Cr>", { noremap = true, silent = true })
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
    ["TermEnter"] = {
      "*",
      function()
        cmd("startinsert | setlocal listchars= nonumber norelativenumber")
      end,
    },
    -- ["BufEnter"] = {
    -- 	"term://*",
    -- 	function()
    -- 		cmd("startinsert! | setlocal listchars= nonumber norelativenumber")
    -- 	end,
    -- },
  },
  restore_cursor = {
    ["BufRead"] = {
      "*",
      function()
        cmd([[call setpos(".", getpos("'\""))]])
      end,
    },
    ["BufEnter"] = {
      "alpha",
      function()
        vim.opt.statuscolumn = nil
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
        vim.highlight.on_yank({ higroup = "Search", timeout = "100" })
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
        "lazy",
        "mason",
        "lspinfo",
        "null-ls-info",
        "tsplayground",
        "noice",
        "notify",
        "diff",
        "qf",
      },
      function()
        vim.api.nvim_buf_set_keymap(0, "n", "q", ":q!<CR>", { silent = true, noremap = true })
      end,
    },
  },
  chechk_html = {
    [{ "BufReadPre", "BufEnter" }] = {
      "*.html",
      function()
        vim.opt.wrap = true
      end,
    },
    ["BufLeave"] = {
      "*.html",
      function()
        vim.opt.wrap = false
      end,
    },
  },
}

local aucmnds = function(group)
  for group_name, definition in pairs(group) do
    for key, value in pairs(definition) do
      autocmd(key, {
        group = augroup(group_name, { clear = true }),
        pattern = value[1],
        callback = value[2],
      })
    end
  end
end

aucmnds(autocmds)

local M = {}

-- Lazy Load Plugins
function M.lazyload(plugins_name)
  autocmd({ "BufReadPre" }, {
    pattern = "*.*",
    group = augroup("LazyLoad " .. plugins_name, { clear = true }),
    callback = function()
      require("lazy").load({ plugins = plugins_name })
    end,
  })
end

-- for commands plugins
M.neo_tree = {
  "Neotree",
  "NeoTreeShow",
  "NeoTreeShowToggle",
  "NeoTreeFlot",
  "NeoTreeFloatToggle",
  "NeoTreeReveal",
  "NeoTreeRevealToggle",
  "NeoTreeFocus",
  "NeoTreeFocusToggle",
  "NeoTreeLogs",
}

M.mason = {
  "Mason",
  "MasonUninsatall",
  "MasonUninsatAll",
  "MasonInstall",
  "MasonLog",
}

M.mason_lsp = {
  "LspInstall",
  "LspUnisntall",
}

M.lsp = {
  "LspInfo",
  "LspStart",
  "LspStop",
  "LspRestart",
  "LspLog",
}

M.treesitter = {
  "TSInstall",
  "TSUninstall",
  "TSInstallSync",
  "TSInstallInfo",
  "TSInstallFromGrammar",
  "TSUpdate",
  "TSUpdateSync",
  "TSBufDisable",
  "TSBufEnable",
  "TSBufToggle",
  "TSConfigInfo",
  "TSEnable",
  "TSDisable",
}

return M
