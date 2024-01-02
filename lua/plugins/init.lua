return {
  { 'nvim-tree/nvim-web-devicons' },

  {
    "b0o/schemastore.nvim",
    lazy = true
  },

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
          transparent = true, -- Disable setting background
        },
      })
    end
  },
}
