return {
  {
    'folke/tokyonight.nvim',
    config = function()
      require 'tokyonight'.setup {
        transparent = true
      }

      vim.cmd.colorscheme 'tokyonight'
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
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    config = function()
      require 'onedarkpro'.setup {
        options = {
          transparency = true
        }
      }
    end,
    event = 'VeryLazy'
  }
}
