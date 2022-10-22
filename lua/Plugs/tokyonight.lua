vim.cmd[[colorscheme tokyonight]]
require("tokyonight").setup({
   style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
   transparent = false, -- Enable this to disable setting the background color
   terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
   styles = {
     -- Style to be applied to different syntax groups
     -- Value is any valid attr-list value for `:help nvim_set_hl`
     comments = { italic = true },
     keywords = { italic = true },
     functions = { bold = true},
     variables = {},
     -- Background styles. Can be "dark", "transparent" or "normal"
     sidebars = "dark", -- style for sidebars, see below
     floats = "dark", -- style for floating windows
   },
   dim_inactive = false, -- dims inactive windows
   lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
   on_colors = function(colors)
    colors.error = "#ff0000"
   end,
   on_highlights = function(highlights, colors) end,
})
