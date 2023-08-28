return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    require 'neogen'.setup {}
  end,
  cmd = 'Neogen',
  keys = {
    { '<leader>n', '<cmd>Neogen<CR>', 'Neogen' }
  }
}
