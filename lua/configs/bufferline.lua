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
  vim.api.nvim_set_keymap('n', '<C-]>', ':BufferLinePick<CR>', { noremap = true, silent = true }),
  vim.api.nvim_set_keymap('n', '<C-[>', ':BufferLinePickClose<CR>', { noremap = true, silent = true }),
}

require('which-key').register({
  b = {
    c = { ':BufferLinePickClose<CR>', 'Buffer Pick Close' },
    h = { ':BufferLineCloseLeft<CR>', 'Close Buffers to the Left' },
    j = { ':BufferLinePick<CR>', 'Buffer Pick' },
    l = { ':BufferLineCloseRight<cr>', 'Close Buffers to the Right' },
  },
}, {
  prefix = '<leader>',
})
