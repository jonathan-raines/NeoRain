local M = { 'numToStr/Comment.nvim' }

M.event = 'BufReadPre'

M.dependencies = 'JoosepAlviste/nvim-ts-context-commentstring'

M.config = function()
  require 'Comment'.setup {
    ignore = '^$',
    pre_hook = require 'ts_context_commentstring.integrations.comment_nvim'.create_pre_hook(),
  }
end

return M
