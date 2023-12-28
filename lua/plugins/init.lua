return {
  { 'nvim-tree/nvim-web-devicons' },

  {
    'Wansmer/symbol-usage.nvim',
    event = 'LspAttach',
    config = function()
      require('symbol-usage').setup {
        vt_position = 'end_of_line'
      }
    end
  },

  {
    'dracula/vim',
    name = 'dracula',
    config = function()
      vim.g['dracula_colorterm'] = 0

      -- vim.cmd.colorscheme 'dracula'
    end
  },

  {
    "EdenEast/nightfox.nvim",
    config = function()
      -- Default options
      require('nightfox').setup({
        options = {
          -- transparent = true, -- Disable setting background
        },
      })

      vim.cmd("colorscheme nightfox")
    end
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true
    },
  }
}
