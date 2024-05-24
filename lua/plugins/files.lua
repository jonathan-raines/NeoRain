return {
  'echasnovski/mini.files',
  config = function()
    require 'mini.files'.setup {}

    vim.api.nvim_create_autocmd("User", {
      desc = 'Set transparent MiniFiles background',
      group = vim.api.nvim_create_augroup('MiniFiles', { clear = true }),
      pattern = 'MiniFilesWindowOpen',
      callback = function()
        vim.api.nvim_set_hl(0, 'MiniFilesNormal', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'MiniFilesBorder', { bg = 'none' })
      end
    })
  end,
  keys = {
    {
      '<leader>fe',
      '<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), true)<CR>',
      desc = 'MiniFiles Current Directory'
    },
    { '<leader>fE', '<cmd>lua MiniFiles.open()<CR>', desc = 'Mini Files CWD' }
  },

}
