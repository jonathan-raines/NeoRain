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
          transparent = true
        },
      }
    end,
    event = 'VeryLazy'
  },

  {
    "sainnhe/sonokai",
    config = function()
      vim.g['sonokai_transparent_background'] = 1

      -- vim.cmd.colorscheme 'sonokai'
    end,
    event = 'VeryLazy'
  },

  {
    'ribru17/bamboo.nvim',
    config = function()
      require 'bamboo'.setup {
        transparent = true
      }

      vim.cmd.colorscheme 'bamboo'
    end,
    -- event = 'VeryLazy'
  },
}
