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

local opts = {
  mode = 'n', -- NORMAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

require('which-key').register({

  f = {
    name = 'Telescope',
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
  },
}, opts)
