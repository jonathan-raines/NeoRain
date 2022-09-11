local M = {}

function _CURR_BUF()
  local opt = require 'telescope.themes'.get_ivy()
  require 'telescope.builtin'.current_buffer_fuzzy_find(opt)
end

M.setup = function()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  local keymaps = {
    ['<leader>b'] = { '<cmd>Telescope buffers theme=get_ivy<CR>', { desc = 'Buffers' } },
    ['<leader>fc'] = { '<cmd>Telescope command_history<CR>', { desc = 'Command History' } },
    ['<leader>fd'] = { '<cmd>Telescope lsp_document_symbols<CR>', { desc = 'Document Symbols' } },
    ['<leader>fe'] = { '<cmd>Telescope file_browser<CR>', { desc = 'File Browser' } },
    ['<leader>ff'] = { '<cmd>Telescope find_files<CR>', { desc = 'Find Files' } },
    ['<leader>fh'] = { '<cmd>Telescope git_status<CR>', { desc = 'Git Status' } },
    ['<leader>fj'] = { '<cmd>Telescope<CR>', { desc = 'Telescope Functions' } },
    ['<leader>fg'] = { '<cmd>Telescope live_grep<CR>', { desc = 'Live Grep' } },
    ['<leader>fo'] = { '<cmd>Telescope oldfiles cwd_only=v:true<CR>', { desc = 'Recent Files' } },
    ['<leader>fq'] = { '<cmd>Telescope quickfix<CR>', { desc = 'Quickfix' } },
    ['<leader>fr'] = { '<cmd>Telescope resume<CR>', { desc = 'Resume' } },
    ['<leader>fs'] = { '<cmd>Telescope grep_string<CR>', { desc = 'Grep String' } },
    ['<leader>ft'] = { '<cmd>Telescope treesitter<CR>', { desc = 'Treesitter' } },
    ['<leader>fw'] = { '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', { desc = 'Workplace Symbols' } },
    ['<leader>/'] = { '<cmd>lua _CURR_BUF()<CR>', { desc = 'Current Buffer' } },
  }

  for key, val in pairs(keymaps) do
    keymap('n', key, val[1], vim.tbl_extend('keep', opts, val[2]))
  end
end

M.config = function()
  local actions = require 'telescope.actions'

  require 'telescope'.setup {
    defaults = {
      layout_config = {
        height = 0.85,
        width = 0.95,
      },
      file_sorter = require 'telescope.sorters'.get_fzy_sorter,
      mappings = {
        i = {
          ['<ESC>'] = actions.close,
        },
        n = {},
      },
      -- Remove indentation at the beginning of a line
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--trim', -- add this value
      },
    },
    pickers = {
      buffers = {
        show_all_buffers = true,
        ignore_current_buffer = true,
        sort_lastused = true,
        mappings = {
          i = {
            ['<A-d>'] = actions.delete_buffer,
          },
          n = {
            ['d'] = actions.delete_buffer,
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
end

return M
