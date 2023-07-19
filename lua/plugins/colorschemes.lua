return {
  {
    'navarasu/onedark.nvim',
    config = function()
      local onedark = require 'onedark'
      onedark.setup {
        code_style = {
          comments = 'italic',
          keywords = 'italic',
          functions = 'italic',
        },
      }
    end,
    event = 'VeryLazy'
  },

  {
    "sainnhe/sonokai",
    -- config = function()
    --   vim.cmd.colorscheme 'sonokai'
    -- end,
    event = 'VeryLazy'
  },

  {
    'ribru17/bamboo.nvim',
    config = function()
      require 'bamboo'.setup {}

      vim.cmd.colorscheme 'bamboo'
    end,
  }
}
