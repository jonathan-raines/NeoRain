require('bufferline').setup {
  highlights = {
    fill = {
      -- guibg = '#16161D',
    },
  },
  options = {
    mode = 'buffers',
    show_buffer_close_icons = false,
    show_close_icons = false,
    show_tab_indications = true,
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

vim.api.nvim_set_keymap('n', '<C-]>', ':BufferLinePick<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-[>', ':BufferLinePickClose<CR>', { noremap = true, silent = true })
