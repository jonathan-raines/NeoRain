local M = {}

M.setup = function()
  vim.keymap.set('n', '<leader>o', require 'portal'.jump_backward, { desc = 'Jump Backward' })
  vim.keymap.set('n', '<leader>i', require 'portal'.jump_forward, { desc = 'Jump Forward' })
end

M.config = function()
  require 'portal'.setup {
    integrations = {
      grapple = true
    },
    query = { 'modified', 'different', 'valid', 'grapple' },
    escape = {
      ['<esc>'] = true,
      ['q'] = true
    },
  }
end

return M
