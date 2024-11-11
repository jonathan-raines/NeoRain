return {
  {
    'projekt0n/github-nvim-theme',
    config = function()
      require 'github-theme'.setup {
        options = {
          transparent = true
        }
      }
    end
  },

  {
    'sainnhe/sonokai',
    config = function()
      vim.g.sonokai_transparent_background = true
    end,
    lazy = true
  },

  {
    "wtfox/jellybeans.nvim",
    priority = 1000,
    config = function()
      require("jellybeans").setup {
        transparent = true
      }
    end,
    lazy = true
  }

}
