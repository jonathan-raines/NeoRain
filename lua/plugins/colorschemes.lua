return {
  {
    'folke/tokyonight.nvim',
    config = function()
      require 'tokyonight'.setup {
        transparent = true,
        dim_inactive = true,
        -- on_highlights = function(hl, c)
        --   local prompt = "#2d3149"
        --   hl.TelescopeNormal = {
        --     bg = c.bg_dark,
        --     fg = c.fg_dark,
        --   }
        --   hl.TelescopeBorder = {
        --     bg = c.bg_dark,
        --     fg = c.bg_dark,
        --   }
        --   hl.TelescopePromptNormal = {
        --     bg = prompt,
        --   }
        --   hl.TelescopePromptBorder = {
        --     bg = prompt,
        --     fg = prompt,
        --   }
        --   hl.TelescopePromptTitle = {
        --     bg = prompt,
        --     fg = prompt,
        --   }
        --   hl.TelescopePreviewTitle = {
        --     bg = c.bg_dark,
        --     fg = c.bg_dark,
        --   }
        --   hl.TelescopeResultsTitle = {
        --     bg = c.bg_dark,
        --     fg = c.bg_dark,
        --   }
        -- end,
      }

      vim.cmd.colorscheme 'tokyonight'
    end
  },

  {
    "sainnhe/sonokai",
    config = function()
      vim.g['sonokai_transparent_background'] = 1
    end,
    event = 'VeryLazy'
  }
}
