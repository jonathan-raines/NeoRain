return {
  'Wansmer/treesj',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  opts = {
    use_default_keymaps = false,
  },
  keys = {
    { 'gs', vim.cmd.TSJToggle, desc = 'Toggle Split' },
  }
}
