return {
  'tpope/vim-fugitive',
  cmd = 'Git',
  keys = {
    { '<leader>gg', vim.cmd.Git, desc = 'Fugitive' }
  },
}
