return {
  'cbochs/grapple.nvim',
  config = function()
    require 'grapple'.setup { scope = 'git_branch' }
  end,
  keys = {
    { '<leader>jj', '<cmd>GrapplePopup tags<CR>',   desc = 'Grapple Menu' },
    { '<leader>jp', vim.cmd.GrappleTag,             desc = 'Grapple Tag' },
    { '<leader>jg', '<cmd>GrappleSelect key=1<CR>', desc = 'Select Tag 1' },
    { '<leader>jf', '<cmd>GrappleSelect key=2<CR>', desc = 'Select Tag 2' },
    { '<leader>jd', '<cmd>GrappleSelect key=3<CR>', desc = 'Select Tag 3' },
    { '<leader>js', '<cmd>GrappleSelect key=4<CR>', desc = 'Select Tag 4' },
    { '<leader>ja', '<cmd>GrappleSelect key=5<CR>', desc = 'Select Tag 5' },
  },
}
