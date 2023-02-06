return {
  'numToStr/Comment.nvim',
  dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
  config = function()
    require 'Comment'.setup {
      ignore = '^$',
      pre_hook = require 'ts_context_commentstring.integrations.comment_nvim'.create_pre_hook(),
    }
  end,
  keys = {
    { 'gc', mode = { 'n', 'x' } },
    { 'gb', mode = { 'n', 'x' } },
  }
}
