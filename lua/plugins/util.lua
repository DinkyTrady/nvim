return {
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {
      clear_empty_lines = true,
      mapping = { "jj", "kk" },
    },
  },
  {
    "echasnovski/mini.indentscope",
    opts = {
      draw = { animation = require("mini.indentscope").gen_animation.none() },
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")

      npairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string" }, -- it will not add a pair on that treesitter node
          javascript = { "template_string" },
          java = false, -- don't check treesitter on java
        },
        enable_check_bracket_line = true,
        fast_wrap = {
          map = "<C-t>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = [=[[%'%"%)%>%]%)%}%,]]=],
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "Search",
          highlight_grey = "Comment",
        },
      })

      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")
      local conds = require("nvim-autopairs.ts-conds")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }

      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      npairs.add_rules({
        Rule("%", "%", "lua"):with_pair(conds.is_ts_node({ "string", "comment" })),
        Rule("$", "$", "lua"):with_pair(conds.is_not_ts_node({ "function" })),
        Rule(" ", " ")
          :with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({
              brackets[1][1] .. brackets[1][2],
              brackets[2][1] .. brackets[2][2],
              brackets[3][1] .. brackets[3][2],
            }, pair)
          end)
          :with_move(cond.none())
          :with_cr(cond.none())
          :with_del(function(opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = opts.line:sub(col - 1, col + 2)
            return vim.tbl_contains({
              brackets[1][1] .. "  " .. brackets[1][2],
              brackets[2][1] .. "  " .. brackets[2][2],
              brackets[3][1] .. "  " .. brackets[3][2],
            }, context)
          end),
        Rule("%(.*%)%s*%=>$", " {  }", { "typescript", "typescriptreact", "javascript" })
          :use_regex(true)
          :set_end_pair_length(2),
      })
      for _, bracket in pairs(brackets) do
        Rule("", " " .. bracket[2])
          :with_pair(cond.none())
          :with_move(function(opts)
            return opts.char == bracket[2]
          end)
          :with_cr(cond.none())
          :with_del(cond.none())
          :use_key(bracket[2])
      end
    end,
  },
  {
    "j-hui/fidget.nvim",
    tag = "v1.0.0",
    event = "BufReadPre",
    config = function()
      require("fidget").setup()
    end,
  },
}
