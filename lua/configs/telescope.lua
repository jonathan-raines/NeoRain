local actions = require 'telescope.actions'

require('telescope').setup {
  defaults = {
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
      ignore_current_buffer = false,
      sort_lastused = true,
      mappings = {
        i = {
          ['<c-d>'] = actions.delete_buffer,
        },
        n = {
          ['<c-d>'] = actions.delete_buffer,
        },
      },
    },
    current_buffer_fuzzy_find = {
      previewer = false,
    },
    find_files = {
      hidden = true,
      file_ignore_patterns = { '.git/' },
      find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
    },
    live_grep = {
      file_ignore_patterns = { '.git/' },
    },
    selection_strategy = 'reset',
    use_less = true,
  },
}

function _CURR_BUF()
  local opt = require('telescope.themes').get_ivy()
  require('telescope.builtin').current_buffer_fuzzy_find(opt)
end
