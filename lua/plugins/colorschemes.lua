return {
  {
    'folke/tokyonight.nvim',
    config = function()
      require 'tokyonight'.setup {
        transparent = true,
        dim_inactive = true,
      }

      vim.cmd.colorscheme 'tokyonight'
    end
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require 'catppuccin'.setup {
        transparent_background = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          mini = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
          treesitter = {
            enabled = true
          },
          telescope = true,
          neogit = true
        }
      }
    end,
    event = 'VeryLazy'
  },

  {
    "sainnhe/sonokai",
    config = function()
      vim.g['sonokai_transparent_background'] = 1
    end,
    event = 'VeryLazy'
  },
}
