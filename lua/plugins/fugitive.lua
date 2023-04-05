return {
  'tpope/vim-fugitive',
  cmd = 'Git',
  keys = {
    { '<leader>gg', vim.cmd.Git,             desc = 'Fugitive' },
    { '<leader>gf', '<cmd>diffget //2 <CR>', desc = 'Get Left Diff' },
    { '<leader>gj', '<cmd>diffget //3 <CR>', desc = 'Get Right Diff' },
    {
      '<leader>gp',
      function()
        vim.cmd.Git 'pull --rebase'
      end,
      desc = 'Git Pull'
    },
    {
      '<leader>gP',
      function()
        vim.cmd.Git 'push'
      end,
      desc = 'Git Push'
    },
  },
}
