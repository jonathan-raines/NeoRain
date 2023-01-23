local M = { 'cbochs/grapple.nvim' }

M.init = function()
  vim.keymap.set('n', '<leader>hq', require 'grapple'.popup_tags, { desc = 'Grapple Menu' })
  vim.keymap.set('n', '<leader>hp', require 'grapple'.toggle, { desc = 'Grapple Tag' })
  vim.keymap.set('n', '<leader>hg', function() require 'grapple'.select { key = 1 } end, { desc = 'Select Tag 1' })
  vim.keymap.set('n', '<leader>hf', function() require 'grapple'.select { key = 2 } end, { desc = 'Select Tag 2' })
  vim.keymap.set('n', '<leader>hd', function() require 'grapple'.select { key = 3 } end, { desc = 'Select Tag 3' })
  vim.keymap.set('n', '<leader>hs', function() require 'grapple'.select { key = 4 } end, { desc = 'Select Tag 4' })
  vim.keymap.set('n', '<leader>ha', function() require 'grapple'.select { key = 5 } end, { desc = 'Select Tag 5' })
end

M.config = function()
  require 'grapple'.setup { scope = 'git_branch' }
end

return M
