local actions = require 'telescope.actions'

require('telescope').setup {
  defaults = {
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    layout_config = {
      height = 0.9,
      width = 0.9,
    },
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    mappings = {
      i = {
        ['<ESC>'] = actions.close,
      },
      n = {},
    },
  },
  pickers = {
    buffers = {
      show_all_buffers = true,
      ignore_current_buffer = true,
      sort_lastused = true,
      mappings = {
        i = {
          ['<c-d>'] = require('telescope.actions').delete_buffer,
        },
        n = {
          ['<c-d>'] = require('telescope.actions').delete_buffer,
        },
      },
    },
    current_buffer_fuzzy_find = {
      previewer = false,
    },
    find_files = {
      hidden = true,
      file_ignore_patterns = { '.git/' },
    },
    live_grep = {
      file_ignore_patterns = { '.git/' },
    },
    selection_strategy = 'reset',
    use_less = true,
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
}

require('telescope').load_extension 'fzy_native'
require('telescope').load_extension 'tmux'

-- Buffers
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers theme=get_ivy<CR>', { noremap = true, silent = true })
