return {
  name = 'nvim-window',
  url = 'https://gitlab.com/yorickpeterse/nvim-window.git',
  keys = {
    { '<C-p>', "<cmd>lua require 'nvim-window'.pick()<CR>", desc = 'Pick a window' }
  }
}
