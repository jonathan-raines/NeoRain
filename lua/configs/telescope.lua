local actions = require 'telescope.actions'

require('telescope').setup {
  defaults = {
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    layout_config = {
      height = 0.9,
      preview_width = 80,
      width = 0.9,
    },
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    mappings = {
      i = {
        ['<c-d>'] = require('telescope.actions').delete_buffer,
        ['<ESC>'] = actions.close,
      },
      n = {
        ['<c-d>'] = require('telescope.actions').delete_buffer,
      },
    },
    pickers = {
      buffers = {
        sort_lastused = true,
        theme = 'dropdown',
      },
      find_files = {
        hidden = true,
        theme = 'dropdown',
      },
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
require('telescope').load_extension 'projects'
