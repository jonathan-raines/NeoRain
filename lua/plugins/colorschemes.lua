return {
  {
    'dracula/vim',
    name = 'dracula',
    config = function()
      vim.g['dracula_colorterm'] = 0
    end
  },

  {
    "navarasu/onedark.nvim",
    config = function()
      require 'onedark'.setup {
        transparent = true
      }
    end
  },

  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup {
        transparent_background = true,
      }
    end
  },

}
