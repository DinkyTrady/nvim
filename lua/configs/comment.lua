local setup = {
  config = {
    "numToStr/Comment.nvim",
    keys = { "gb", "gc" },
    config = function()
      local comment_ok, comment = pcall(require, "Comment")
      if not comment_ok then
        return
      end

      comment.setup({
        pre_hook = function()
          return vim.bo.commentstring
        end,
      })
    end,
  },
}

return setup
