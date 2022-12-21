return {
  {
    'ThePrimeagen/refactoring.nvim',
    init = function()
      -- prompt for a refactor to apply when the remap is triggered
      vim.keymap.set('v', '<leader>r', function()
        require 'refactoring'.select_refactor()
      end, { noremap = true, silent = true, expr = false })
    end,
    config = function()
      require 'refactoring'.setup {}
    end,
    enabled = false
  },

  {
    'Wansmer/treesj',
    cmd = 'TSJToggle',
    config = function()
      require 'treesj'.setup { use_default_keymaps = false }
    end,
    enabled = true
  },

  {
    'cshuaimin/ssr.nvim',
    init = function()
      vim.keymap.set({ 'n', 'x' }, '<leader>cR', function()
        require 'ssr'.open()
      end, { desc = 'Structural Replace' })
    end,
    enabled = false
  },


  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]
    end
  }
}
