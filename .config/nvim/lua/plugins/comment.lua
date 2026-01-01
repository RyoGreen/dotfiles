-- Comment.nvim configuration
local status_ok, comment = pcall(require, "Comment")
if not status_ok then return end

comment.setup({
  padding = true,
  sticky = true,
  mappings = {
    basic = true,
    extra = true,
  },
})
