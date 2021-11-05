local telescope = require 'telescope'
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

local function tmux_sessions()
  telescope.extensions.tmux.sessions {}
end

local function tmux_windows()
  telescope.extensions.tmux.windows {
    entry_format = '#S: #T',
  }
end

require('which-key').register({
  f = {
    name = 'Telescope',
    b = { '<cmd>Telescope buffers theme=get_ivy<CR>', 'Buffers' },
    e = { '<cmd>Telescope file_browser<cr>', 'File Browser' },
    d = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document Symbols' },
    f = { '<cmd>Telescope find_files<CR>', 'Find Files' },
    h = {
      name = 'History',
      c = { '<cmd>Telescope command_history<cr>', 'Command History' },
      s = { '<cmd>Telescope search_history<cr>', 'Search History' },
      f = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
    },
    s = {
      name = 'Search',
      b = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Search Current Buffer' },
      s = { '<cmd>Telescope grep_string<cr>', 'Grep String' },
      w = { '<cmd>Telescope live_grep<cr>', 'Live Grep' },
    },
    t = { '<cmd>Telescope treesitter<cr>', 'Treesitter' },
    w = { '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', 'Workplace Symbols' },
    T = {
      name = 'Tmux',
      s = { tmux_sessions, 'Sessions' },
      w = { tmux_windows, 'Windows' },
    },
  },
}, {
  prefix = '<leader>',
})
