return {
  'echasnovski/mini.comment',
  dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
  config = function()
    require 'mini.comment'.setup {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end
      }
    }
  end,
  keys = {
    { 'gc', mode = { 'n', 'x' } },
  }
}
