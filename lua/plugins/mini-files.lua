return {
  'echasnovski/mini.files',
  version = false,
  config = function()
    require 'mini.files'.setup {}
  end,
  keys = {
    { '<leader>e', '<cmd>lua MiniFiles.open()<CR>', desc = 'Files' },
    {
      '-',
      '<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), true)<CR>',
      desc = 'Files Current Directory'
    }
  },
}
