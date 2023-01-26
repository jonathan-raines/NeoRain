local M = {
  'tpope/vim-fugitive',
  cmd = 'Git',
  keys = {
    { '<leader>gg', vim.cmd.Git, desc = 'Fugutive' }
  },
}

return M
