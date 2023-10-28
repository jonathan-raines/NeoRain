return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require('oil').setup()
  end,
  cmd = { 'Oil' },
  keys = {
    { '<leader>e', '<cmd>Oil<CR>', desc = 'File Explorer' }
  },
  lazy = false
}
