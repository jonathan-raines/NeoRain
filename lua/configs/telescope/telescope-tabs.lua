local M = {}

M.setup = function()
  vim.keymap.set('n', '<leader>v', '<cmd>Telescope telescope-tabs list_tabs initial_mode=normal<CR>',
    { silent = true, remap = true, desc = 'Tabs' })
end

M.config = function()
  require 'telescope-tabs'.setup { show_preview = false }
end

return M
