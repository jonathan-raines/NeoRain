return {
  'tpope/vim-fugitive',
  cmd = { 'Git', 'G' },
  keys = {
    { '<leader>hh', [[:tab Git<CR>]], { desc = 'Fugitive' } },
  }
}
