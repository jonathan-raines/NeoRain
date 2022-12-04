local M = {}

M.config = function()
  vim.keymap.set('n', '<leader>hq', require 'grapple'.popup_tags, { desc = 'Grapple Menu' })
  vim.keymap.set('n', '<leader>h/', ':GrappleSelect key=', { desc = 'Grapple Select Name' })
  vim.keymap.set('n', '<leader>hp', require 'grapple'.toggle, { desc = 'Grapple Tag' })
  vim.keymap.set('n', '<leader>hP', ':GrappleTag key=', { desc = 'Grapple Tag Name' })
  vim.keymap.set('n', '<leader>hf', "<CMD>lua require 'grapple'.select { key = 1 }<CR>", { desc = 'Select Tag 1' })
  vim.keymap.set('n', '<leader>hd', "<CMD>lua require 'grapple'.select { key = 2 }<CR>", { desc = 'Select Tag 2' })
  vim.keymap.set('n', '<leader>hs', "<CMD>lua require 'grapple'.select { key = 3 }<CR>", { desc = 'Select Tag 3' })
  vim.keymap.set('n', '<leader>ha', "<CMD>lua require 'grapple'.select { key = 4 }<CR>", { desc = 'Select Tag 4' })
end

return M
