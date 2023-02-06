return {
  'navarasu/onedark.nvim',
  priority = 1000,
  lazy = false,
  config = function()
    local onedark = require 'onedark'
    onedark.setup {
      code_style = {
        comments = 'italic',
        keywords = 'italic',
        functions = 'italic',
      },
    }
  end
}
