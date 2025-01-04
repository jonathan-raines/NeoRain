MiniDeps.later(function()
  require 'mini.files'.setup {}

  vim.keymap.set('n', '<leader>e', '<cmd>lua MiniFiles.open()<CR>', { desc = 'File Explorer' })
  vim.keymap.set('n', '-', '<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), true)<CR>',
    { desc = 'Mini Files Current Directory' })
end)
