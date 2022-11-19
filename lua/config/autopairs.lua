local npairs_ok, npairs = pcall(require, "nvim-autopairs")
if not npairs_ok then
  return
end

local Rule_ok, Rule = pcall(require, "nvim-autopairs.rule")
if not Rule_ok then
  return
end

local ts_conds_ok, ts_conds = pcall(require, "nvim-autopairs.ts-conds")
if not ts_conds_ok then
  return
end

local cmp_autopairs_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not cmp_autopairs_ok then
  return
end

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

local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
