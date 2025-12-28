local lsp_core = require 'core.lsp-core'

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- 'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    -- TODO: keep this commit for now until fixed
    -- https://github.com/neovim/nvim-lspconfig/pull/4027
    commit = '63a016437e44283e4aa54802be3002d06f724253',
    event = 'BufReadPre',
    opts = {
      servers = {
        lua_ls = {},
        vtsls = {},
        eslint = {},
        jsonls = {},
        emmet_language_server = {},
        tailwindcss = {},
        cssls = {},
        html = {},
        yamlls = {},
        bashls = {},
        fish_lsp = {},
        dockerls = {},
        clangd = {},
        gopls = {},
      },
    },
    config = function(_, opts)
      for server, settings in pairs(opts.servers) do
        vim.lsp.enable(server)
        vim.lsp.config(server, { capabilities = lsp_core.capabilities, on_attach = lsp_core.on_attach, settings })
      end
    end,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- made luv library not avaiable only when type vim.uv
        -- it will need to load lsp again to get the library
        { path = '${3rd}/luv/library' },
        vim.fn.stdpath 'data' .. '/lazy/snacks.nvim',
      },
    },
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('lint').linters_by_ft = {
        fish = { 'fish' },
        typescript = { 'eslint' },
        ShellCheck = { 'shellcheck' },
        php = { 'phpcs' },
      }
    end,
  },
  {
    'mason-org/mason.nvim',
    event = 'BufRead',
    cmd = { 'Mason', 'MasonLog', 'MasonUpdate', 'MasonUninstall', 'MasonUninstallAll' },
    opts = {},
  },
  -- {
  --   'pmizio/typescript-tools.nvim',
  --   ft = { 'typescript', 'javascript' },
  --   dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  --   config = function()
  --     require('typescript-tools').setup {
  --       on_attach = lsp_core.on_attach,
  --       settings = {
  --         tsserver_file_preferences = {
  --           quotePrefrence = 'single',
  --           includeInlayParameterNameHints = 'literals',
  --           includeInlayEnumMemberValueHints = true,
  --           includeInlayFunctionLikeReturnTypeHints = true,
  --           includeInlayFunctionParameterTypeHints = true,
  --           includeInlayPropertyDeclarationTypeHints = true,
  --           includeInlayVariableTypeHints = true,
  --         },
  --       },
  --     }
  --   end,
  -- },
  {
    'nvim-flutter/flutter-tools.nvim',
    ft = 'dart',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- 'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
      require('flutter-tools').setup {
        -- fvm = true,
        lsp = {
          on_attach = lsp_core.on_attach,
        },
      }
    end,
  },
}
