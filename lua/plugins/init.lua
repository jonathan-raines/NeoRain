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

  {
    'williamboman/mason.nvim',
    config = function()
      require 'mason'.setup()
    end
  },

  { 'rebelot/kanagawa.nvim', lazy = true, priority = 1000 },

  { 'savq/melange-nvim', lazy = true, priority = 1000 },

}
