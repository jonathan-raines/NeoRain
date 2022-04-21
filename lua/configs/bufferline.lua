require('bufferline').setup {
  options = {
    show_buffer_close_icons = false,
    show_close_icons = false,
    offsets = {
      {
        filetype = 'NvimTree',
        text = function()
          return vim.fn.getcwd()
        end,
        highlight = 'Directory',
        text_align = 'left',
      },
    },
    middle_mouse_command = 'bdelete! %d',
    right_mouse_command = 'vertical sbuffer %d',
  },
}

vim.api.nvim_set_keymap('n', '<C-]>', '<cmd>BufferLinePick<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-[>', '<cmd>BufferLinePickClose<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>BufferLinePickClose<CR>', { noremap = true, silent = true })
