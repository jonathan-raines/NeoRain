local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('n', '<leader>re', '<Plug>RestNvim', vim.tbl_extend('keep', opts, { desc = 'Execute request' }))
keymap('n', '<leader>rl', '<Plug>RestNvimLast', vim.tbl_extend('keep', opts, { desc = 'Execute last request' }))
keymap('n', '<leader>rp', '<Plug>RestNvimPreview', vim.tbl_extend('keep', opts, { desc = 'Preview request' }))
