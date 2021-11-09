local telescope = require 'telescope'
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

local mappings = {}

mappings.curr_buf = function()
  local opt = require('telescope.themes').get_ivy()
  require('telescope.builtin').current_buffer_fuzzy_find(opt)
end

local wk = require 'which-key'
wk.register({
  f = {
    name = 'Telescope',
    b = { '<cmd>Telescope buffers theme=get_ivy<CR>', 'Buffers' },
    d = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document Symbols' },
    f = { '<cmd>Telescope find_files<CR>', 'Find Files' },
    e = { '<cmd>Telescope file_browser theme=get_ivy<cr>', 'File Browser' },
    g = { '<cmd>Telescope live_grep<cr>', 'Live Grep' },
    r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
    s = { '<cmd>Telescope grep_string<cr>', 'Grep String' },
    t = { '<cmd>Telescope treesitter<cr>', 'Treesitter' },
    w = { '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', 'Workplace Symbols' },
  },
}, {
  prefix = '<leader>',
})

wk.register({
  b = { '<cmd>Telescope buffers theme=get_ivy<CR>', 'Buffers' },
  e = { "<cmd>lua require('telescope.builtin').file_browser(require('telescope.themes').get_ivy({cwd = vim.fn.expand('%:p:h')}))<CR>", 'Find Files' },
  ['<c-_>'] = { mappings.curr_buf, 'Search Current Buffer' },
}, opts)
