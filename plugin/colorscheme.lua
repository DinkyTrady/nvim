require 'lazyload'.lazy_load {
  {
    src = 'https://github.com/catppuccin/nvim',
    version = 'v1.11.0',
    name = 'catppuccin',
    data = {
      lazy = false,
      config = function()
        local last_set_hour = -1

        local function catppuccin_theme_based_on_time()
          local current_hour = tonumber(os.date '%H')

          if current_hour ~= last_set_hour then
            local flavour = 'mocha'
            if not (current_hour > 5 and current_hour < 18) then
              flavour = 'mocha'
            end

            require('catppuccin').setup {
              flavour = flavour,
              transparent_background = true,
              highlight_overrides = {
                all = function(colors)
                  return {
                    ['@comment.todo'] = { fg = colors.base, bg = colors.blue, style = { 'bold' } },
                    ['@comment.hack'] = { fg = colors.base, bg = colors.yellow, style = { 'bold' } },
                    ['@comment.note'] = { fg = colors.base, bg = colors.green, style = { 'bold' } },
                    Hack = { fg = colors.base, bg = colors.blue },
                    EndOfBuffer = { link = 'LineNr' },
                    StatusLine = { bg = '' },
                    Folded = { bg = '' },
                    FoldColumn = { fg = colors.blue },
                  }
                end,
              },
            }

            vim.cmd.colorscheme 'catppuccin'
            last_set_hour = current_hour
          end
        end

        local timer = vim.uv.new_timer()
        timer:start(0, 180, vim.schedule_wrap(catppuccin_theme_based_on_time))
      end
    }
  }
}
