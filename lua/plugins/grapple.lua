return {
  'cbochs/grapple.nvim',
  config = function()
    require 'grapple'.setup { scope = 'git_branch' }
  end,
  keys = {
    { '<leader>hq', '<cmd>GrapplePopup tags<CR>',   desc = 'Grapple Menu' },
    { '<leader>hp', vim.cmd.GrappleTag,             desc = 'Grapple Tag' },
    { '<leader>hg', '<cmd>GrappleSelect key=1<CR>', desc = 'Select Tag 1' },
    { '<leader>hf', '<cmd>GrappleSelect key=2<CR>', desc = 'Select Tag 2' },
    { '<leader>hd', '<cmd>GrappleSelect key=3<CR>', desc = 'Select Tag 3' },
    { '<leader>hs', '<cmd>GrappleSelect key=4<CR>', desc = 'Select Tag 4' },
    { '<leader>ha', '<cmd>GrappleSelect key=5<CR>', desc = 'Select Tag 5' },
  },
  enabled = false
}
