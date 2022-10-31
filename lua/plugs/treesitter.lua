local treesitter_ok, treesitter = pcall(require, 'nvim-treesitter.configs')

if not treesitter_ok then
  return
end

local context_ok, context = pcall(require, 'treesitter-context.config')
if not context_ok then
  return 
end

treesitter.setup({
  ensure_installed = { 'lua', 'javascript', 'html', 'css', 'query' },
  sync_install = true,
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  },
  rainbow = {
    enable = true,
    extended_mode = false,
    max_file_lines = nil,
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  autotag = {
    enable = true
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  refactor = {
    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = true,
    },
    highlight_current_scope = { enable = true },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
      },
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      include_surrounding_whitespace = true,
    },
    move = {
      enable = true,
      set_jumps = true, 
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer'
      },
      go_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer'
      },
      go_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer'
      },
      go_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer'
      },
    }
  },
})

context.setup{
  enable = true,
}
