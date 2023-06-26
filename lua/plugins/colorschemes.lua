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

      vim.cmd.colorscheme 'onedark'
    end
  },

  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup {}

      -- vim.cmd.colorscheme 'monokai-pro'
    end,
    event = 'VeryLazy'
  },

  {
    'ribru17/bamboo.nvim',
    config = function()
      require 'bamboo'.setup {}
    end
  }
}
