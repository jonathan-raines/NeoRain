local M = {}

M.setup = function()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  local keymaps = {
    ['<S-Tab>'] = { '<cmd>Telescope buffers<CR>', { desc = 'Buffers' } },
    ['<leader>b'] = { '<cmd>Telescope buffers<CR>', { desc = 'Buffers' } },
    ['<leader>fc'] = { '<cmd>Telescope command_history<CR>', { desc = 'Command History' } },
    ['<leader>fe'] = { '<cmd>Telescope file_browser initial_mode=normal<CR>', { desc = 'File Browser' } },
    ['<leader>ff'] = { '<cmd>Telescope find_files<CR>', { desc = 'Find Files' } },
    ['<leader>fg'] = { '<cmd>Telescope live_grep<CR>', { desc = 'Live Grep' } },
    ['<leader>fh'] = { '<cmd>Telescope git_status<CR>', { desc = 'Git Status' } },
    ['<leader>fj'] = { '<cmd>Telescope<CR>', { desc = 'Telescope Functions' } },
    ['<leader>fo'] = { '<cmd>Telescope oldfiles cwd_only=v:true<CR>', { desc = 'Recent Files' } },
    ['<leader>fq'] = { '<cmd>Telescope quickfix<CR>', { desc = 'Quickfix' } },
    ['<leader>fr'] = { '<cmd>Telescope resume<CR>', { desc = 'Resume' } },
    ['<leader>fs'] = { '<cmd>Telescope grep_string<CR>', { desc = 'Grep String' } },
    ['<leader>ft'] = { '<cmd>Telescope treesitter<CR>', { desc = 'Treesitter' } },
    ['<leader>/'] = { '<cmd>Telescope current_buffer_fuzzy_find<CR>', { desc = 'Current Buffer' } },
  }

  for key, val in pairs(keymaps) do
    keymap('n', key, val[1], vim.tbl_extend('keep', opts, val[2]))
  end
end

M.config = function()
  local actions = require 'telescope.actions'

  local pickers = {
    buffers = {
      previewer = false,
      initial_mode = 'normal',
      sort_lastused = true,
      mappings = {
        i = {
          ['<A-d>'] = actions.delete_buffer,
        },
        n = {
          ['d'] = actions.delete_buffer,
          ['q'] = actions.close
        },
      },
    },
    find_files = {
      hidden = true,
      previewer = false,
      file_ignore_patterns = { '.git/' },
    },
    git_files = {
      hidden = true,
      previewer = false,
      show_untracked = true,
    },
    grep_string = {
      only_sort_text = true,
    },
    live_grep = {
      only_sort_text = true,
    },
    oldfiles = {
      hidden = true,
      previewer = false,
    },
    lsp_definitions = {
      initial_mode = 'normal',
    },
    lsp_declarations = {
      initial_mode = 'normal',
    },
    lsp_implementations = {
      initial_mode = 'normal',
    },
    lsp_references = {
      initial_mode = 'normal',
    },
  }

  require 'telescope'.setup {
    defaults = {
      layout_strategy = 'center',
      layout_config = {
        width = 0.8,
        height = 0.4
      },
      sorting_strategy = 'ascending',
      file_sorter = require 'telescope.sorters'.get_fzy_sorter,
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--trim',
      },
      mappings = {
        i = {
          ['<ESC>'] = actions.close,
        },
        n = {
          ['q'] = actions.close,
        },
      },
      border = true,
      borderchars = {
        prompt = { '─', '│', ' ', '│', '╭', '╮', '│', '│' },
        results = { '─', '│', '─', '│', '├', '┤', '╯', '╰' },
        preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      },
    },
    pickers = pickers
  }
end

return M
