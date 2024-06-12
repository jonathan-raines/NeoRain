return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  keys = {
    { '<leader>do', vim.cmd.DiffviewOpen,                           desc = '[Diffview] Open' },
    { '<leader>dc', vim.cmd.DiffviewClose,                          desc = '[Diffview] Close' },
    { '<leader>df', function() vim.cmd.DiffviewFileHistory '%' end, desc = '[Diffview] File History' },
    { '<leader>dh', vim.cmd.DiffviewFileHistory,                    desc = '[Diffview] History' }
  }
}
