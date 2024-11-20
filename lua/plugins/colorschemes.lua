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
    "catppuccin/nvim",
    name = "catppuccin",
    opts = { transparent_background = true },
    lazy = true
  }

}
