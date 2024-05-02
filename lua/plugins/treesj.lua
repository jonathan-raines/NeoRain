return {
  {
    'Wansmer/treesj',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require('treesj').setup { max_join_length = 999, use_default_keymaps = false }
    end,
    keys = {
      { 'gs', vim.cmd.TSJToggle, desc = 'Toggle Split' },
    },
  },
}
