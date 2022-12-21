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
    keys = 'J',
    config = function()
      require 'treesj'.setup { use_default_keymaps = false }
      vim.keymap.set('n', 'J', '<cmd>TSJToggle<cr>')
    end,
    enabled = false
  },

  {
    'cshuaimin/ssr.nvim',
    -- Calling setup is optional.
    init = function()
      vim.keymap.set({ 'n', 'x' }, '<leader>cR', function()
        require 'ssr'.open()
      end, { desc = 'Structural Replace' })
    end,
    enabled = false
  },
}
