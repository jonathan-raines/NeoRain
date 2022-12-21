local M = { 'mbbill/undotree' }

M.init = function()
  vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Undotree' })
end

M.cmd = 'UndotreeToggle'

return M
