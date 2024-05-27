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
    "loctvl842/monokai-pro.nvim",
    opts = {
      transparent_background = true
    },
    event = 'Colorscheme'
  },

}
