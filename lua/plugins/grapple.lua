return {
  'cbochs/grapple.nvim',
  init = function()
    vim.api.nvim_create_autocmd('VimEnter', {
      desc = 'Load grapple scope',
      pattern = '*',
      callback = function()
        vim.cmd [[ GrappleTags ]]
      end,
      group = vim.api.nvim_create_augroup('Misc', { clear = true })
    })
  end,
  config = function()
    require 'grapple'.setup { scope = 'git_branch' }
  end,
  keys = {
    { '<leader>gg', '<cmd>GrapplePopup tags<CR>',   desc = 'Grapple Menu' },
    { '<leader>ga', vim.cmd.GrappleTag,             desc = 'Grapple Tag' },
    { '<leader>gj', '<cmd>GrappleSelect key=1<CR>', desc = 'Select Tag 1' },
    { '<leader>gk', '<cmd>GrappleSelect key=2<CR>', desc = 'Select Tag 2' },
    { '<leader>gl', '<cmd>GrappleSelect key=3<CR>', desc = 'Select Tag 3' },
    { '<leader>g;', '<cmd>GrappleSelect key=4<CR>', desc = 'Select Tag 4' },
  },
  lazy = false
}
