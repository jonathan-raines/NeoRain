return {
  {
    'ofirgall/ofirkai.nvim',
    config = function()
      require 'ofirkai'.setup {}

      vim.cmd.colorscheme 'ofirkai'
    end,
    priority = 1000,
    lazy = false,
    branch = 'exp'
  },

  {
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
  },

}
