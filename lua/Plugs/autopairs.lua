local npairs = require "nvim-autopairs"
npairs.setup {
  check_ts = true,
}
npairs.add_rules(require "nvim-autopairs.rules.endwise-lua")
require("nvim-ts-autotag").setup { enable = true }
