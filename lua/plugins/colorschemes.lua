return {
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000, lazy = false },

  {
    'navarasu/onedark.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      local onedark = require 'onedark'
      onedark.setup {
        code_style = {
          comments = 'italic',
          keywords = 'italic',
          functions = 'italic',
        },
      }

      vim.cmd.colorscheme 'onedark'
    end
  },

  {
    'sainnhe/sonokai',
    config = function()
      vim.g.sonokai_enable_italic = 1
      vim.g.sonokai_transparent_background = 1
      vim.g.sonokai_better_performance = 1
      vim.g.sonokai_disable_terminal_colors = 1
      vim.g.sonokai_dim_inactive_windows = 1
    end,
    priority = 1000,
    lazy = false
  },

  {
    'folke/tokyonight.nvim',
    config = function()
      require 'tokyonight'.setup {
        style = 'storm', -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        transparent = true, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = 'dark', -- style for sidebars, see below
          floats = 'dark', -- style for floating windows
        },
        sidebars = { 'qf', 'help' }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = true, -- dims inactive windows
      }
    end,
    priority = 1000,
    lazy = false
  },

}
