return {
  { 'nvim-tree/nvim-web-devicons' },

  {
    'ribru17/bamboo.nvim',
    config = function()
      require('bamboo').setup { transparent = true }

      -- require('bamboo').load()
    end,
    event = 'VeryLazy'
  },

  {
    'dracula/vim',
    name = 'dracula',
    config = function()
      vim.g['dracula_colorterm'] = 0

      vim.cmd.colorscheme 'dracula'
    end,
    -- event = 'VeryLazy'
  },

  {
    "sainnhe/sonokai",
    config = function()
      vim.g['sonokai_transparent_background'] = 1
    end,
    event = 'VeryLazy'
  },

  {
    'echasnovski/mini.hipatterns',
    version = false,
    config = function()
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
    event = 'VeryLazy'
  },

  {
    'Wansmer/symbol-usage.nvim',
    event = 'LspAttach',
    config = function()
      require('symbol-usage').setup {
        vt_position = 'end_of_line'
      }
    end
  },

}
