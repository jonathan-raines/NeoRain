return {
  'tpope/vim-fugitive',
  cmd = { 'Git', 'G' },
  keys = {
    { "<Leader>hh", vim.cmd.Git, desc = "Fugitive" }
  }
}
