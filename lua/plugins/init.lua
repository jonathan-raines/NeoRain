return {
  { 'nvim-tree/nvim-web-devicons' },

  {
    'ribru17/bamboo.nvim',
    config = function()
      require('bamboo').setup {
        transparent = true
      }
      require('bamboo').load()
    end
  },

  {
    'folke/tokyonight.nvim',
    config = function()
      require 'tokyonight'.setup {
        transparent = true
      }
    end
  },

  {
    "sainnhe/sonokai",
    config = function()
      vim.g['sonokai_transparent_background'] = 1
    end
  },

}
