return {
  {
    'dracula/vim',
    name = 'dracula',
    config = function()
      vim.g['dracula_colorterm'] = 0
    end
  },

  {
    "EdenEast/nightfox.nvim",
    config = function()
      require('nightfox').setup({
        options = {
          transparent = true
        },
      })
    end
  },
}
