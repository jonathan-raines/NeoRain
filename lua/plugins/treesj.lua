return {
  {
    'Wansmer/treesj',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    opts = {
      max_join_length = 999,
      use_default_keymaps = false,
    },
    keys = {
      { 'gs', vim.cmd.TSJToggle, desc = 'Toggle Split' },
    },
  },
}
