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
    "folke/tokyonight.nvim",
    opts = {
      transparent = true
    },
    event = 'Colorscheme'
  },

  {
    'sainnhe/sonokai',
    config = function()
      vim.g.sonokai_transparent_background = true
    end,
    event = 'Colorscheme'
  }

}
