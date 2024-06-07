return {
  {
    'dracula/vim',
    name = 'dracula',
    config = function()
      vim.g['dracula_colorterm'] = 0
    end,
    event = 'Colorscheme'
  },

  {
    'sainnhe/sonokai',
    config = function()
      vim.g.sonokai_transparent_background = true
    end,
    event = 'Colorscheme'
  },

  {
    'projekt0n/github-nvim-theme',
    config = function()
      require 'github-theme'.setup {
        options = {
          transparent = true
        }
      }
    end
  }

}
