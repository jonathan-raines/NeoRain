return {
  {
    'dracula/vim',
    name = 'dracula',
    config = function()
      vim.g['dracula_colorterm'] = 0
    end,
    lazy = true
  },

  {
    "navarasu/onedark.nvim",
    config = function()
      require 'onedark'.setup {
        transparent = true
      }
    end,
    lazy = true
  },
}
