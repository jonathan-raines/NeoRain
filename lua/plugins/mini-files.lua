return {
  'echasnovski/mini.files',
  config = function()
    require('mini.files').setup()
  end,
  keys = {
    { '<leader>fe', "<cmd>lua MiniFiles.open()<cr>",                             desc = 'File Explorer' },
    { '<leader>fE', "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>", desc = 'File Explorer' },
  }
}

