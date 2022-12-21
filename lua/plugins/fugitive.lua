local M = { 'tpope/vim-fugitive' }

M.cmd = 'Git'

M.init = function()
  vim.keymap.set('n', '<leader>gg', vim.cmd.Git, { desc = 'Fugitive' })
end

return M
