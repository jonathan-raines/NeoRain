return {
  name = 'nvim-window',
  url = 'https://gitlab.com/yorickpeterse/nvim-window.git',
  keys = {
    { '<leader><leader>', "<cmd>lua require 'nvim-window'.pick()<CR>", desc = 'Pick a window' }
  }
}
