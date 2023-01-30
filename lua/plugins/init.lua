return {
  {
    'Wansmer/treesj',
    cmd = 'TSJToggle',
    config = function()
      require 'treesj'.setup { use_default_keymaps = false }
    end
  },

  {
    'rareitems/printer.nvim',
    keys = 'gp',
    config = function()
      require 'printer'.setup {
        keymap = 'gp' -- Plugin doesn't have any keymaps by default
      }
    end
  },

  { 'savq/melange-nvim', priority = 1000, lazy = false },

  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000, lazy = false },

  {
    'navarasu/onedark.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      local onedark = require 'onedark'
      onedark.setup {
        -- transparent = true
      }

      onedark.load()
    end,
  }
}
