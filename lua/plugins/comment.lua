local M = {
  'numToStr/Comment.nvim',
  dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
  keys = {
    { 'gc', mode = { 'n', 'x' } },
    { 'gb', mode = { 'n', 'x' } },
  }
}

M.config = function()
  require 'Comment'.setup {
    ignore = '^$',
    pre_hook = require 'ts_context_commentstring.integrations.comment_nvim'.create_pre_hook(),
  }
end

return M
