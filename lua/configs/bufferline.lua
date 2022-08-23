require 'bufferline'.setup {
  options = {
    show_buffer_close_icons = false,
    show_close_icons = false,
    middle_mouse_command = 'bdelete! %d',
    right_mouse_command = 'vertical sbuffer %d',
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'File Explorer',
        highlight = 'Directory',
        text_align = 'left'
      }
    },
  },
  vim.api.nvim_set_keymap('n', '<C-]>', ':BufferLinePick<CR>', { noremap = true, silent = true }),
  vim.api.nvim_set_keymap('n', '<C-[>', ':BufferLinePickClose<CR>', { noremap = true, silent = true }),
}
