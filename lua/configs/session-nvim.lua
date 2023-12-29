return {
  "folke/persistence.nvim",
  event = require("core.commands").lazyload("persistence.nvim"),
  opts = { options = vim.opt.sessionoptions:get() },
  keys = {
    vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {}),
    vim.api.nvim_set_keymap("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {}),
    vim.api.nvim_set_keymap("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]], {}),
  },
}
