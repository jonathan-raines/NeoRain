return {
  'tpope/vim-fugitive',
  cmd = { 'Git', 'G' },
  keys = {
    { '<leader>gs', [[:tab G<CR>]],   desc = '[Fugitive] Status' },
    { '<leader>gb', [[:G blame<CR>]], desc = '[Fugitive] Blame' },
  },
}
