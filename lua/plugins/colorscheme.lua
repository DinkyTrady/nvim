return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			      flavour = "macchiato",
      -- transparent_background = true,
      intergrations = {
        lualine = true,
      },
      highlight_overrides = {
        ["macchiato"] = function(colors)
          return {
            BufferLineBufferSelected = { fg = colors.lavender },
            NavicText = { link = "@variable" },
            ["@property.css"] = { link = "@field" },
            ["@property.toml"] = { link = "@field" },
            ["@text.uri"] = { link = "String" },
            ["@tag.attribute"] = { link = "Function" },
            ["@tag.delimiter"] = { fg = colors.lavender },
            ["@function.builtin"] = { link = "Function" },
            ["@field"] = { fg = "#73daca" },
            ["@property"] = { link = "@field" },
          }
        end,
      },

		})

		vim.cmd("colorscheme catppuccin")
	end
}
