local M = {
  'mbbill/undotree',
  cmd = 'UndotreeToggle'
}

M.init = function()
  vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Undotree' })
end

return M
