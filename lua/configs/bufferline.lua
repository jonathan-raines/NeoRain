require 'bufferline'.setup {
  options = {
    show_buffer_close_icons = false,
    show_close_icons = false,
    middle_mouse_command = 'bdelete! %d',
    right_mouse_command = 'vertical sbuffer %d',
  },
}

vim.api.nvim_set_keymap('n', '<C-p>', ':BufferLinePick<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-p>', ':BufferLinePickClose<CR>', { noremap = true, silent = true })
