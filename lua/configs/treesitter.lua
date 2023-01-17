local treesitter_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_ok then
  return
end

treesitter.setup({
  ensure_installed = {
    "lua",
    "javascript",
    "html",
    "help",
    "c",
    "cpp",
    "json",
  },
  sync_install = false,
  highlight = {
    enable = true,
    -- additional_vim_regex_highlighting = false,
    -- disable = { "html", "css" },
  },
  indent = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = false,
    max_file_lines = nil,
    disable = { "html" },
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  autotag = {
    enable = true,
    disable = { "xml", "markdown" },
    filetypes = {
      "html",
      "javascript",
      "javascriptreact",
      "svelte",
      "typescript",
      "typescriptreact",
      "vue",
    },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  playground = {
    enable = true,
  },
})
