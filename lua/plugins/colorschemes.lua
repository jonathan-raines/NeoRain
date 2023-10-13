return {
  {
    'folke/tokyonight.nvim',
    config = function()
      require 'tokyonight'.setup {
        transparent = true
      }

      -- vim.cmd.colorscheme 'tokyonight'
    end
  },

  {
    "sainnhe/sonokai",
    config = function()
      vim.g['sonokai_transparent_background'] = 1
    end,
    event = 'VeryLazy'
  },

  {
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('bamboo').setup {
        transparent = true
      }
      require('bamboo').load()
    end,
  }
}
