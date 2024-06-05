return {
  'sindrets/diffview.nvim',
  cmd = 'DiffviewOpen',
  keys = {
    { '<leader>do', vim.cmd.DiffviewOpen,  desc = '[Diffview] Open' },
    { '<leader>dc', vim.cmd.DiffviewClose, desc = '[Diffview] Close' }
  }
}
