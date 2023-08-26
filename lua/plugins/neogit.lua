return {
  {
    'NeogitOrg/neogit',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require 'neogit'.setup {}
    end,
    cmd = 'Neogit'
  },

  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G' }
  }
}
