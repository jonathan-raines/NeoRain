return {
  { 'nvim-tree/nvim-web-devicons' },

  {
    'ribru17/bamboo.nvim',
    config = function()
      require('bamboo').setup {
        transparent = true
      }

      require('bamboo').load()
    end
  },

  {
    "sainnhe/sonokai",
    config = function()
      vim.g['sonokai_transparent_background'] = 1
    end
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

}
