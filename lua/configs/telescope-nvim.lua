local M = {}

local keymap = vim.keymap.set
local builtin = require 'telescope.builtin'
local actions = require 'telescope.actions'
local themes = require 'telescope.themes'

M.setup = function()
  local keymaps = {
    ['<leader>b'] = { builtin.buffers, { desc = '[B]uffers' } },
    ['<leader>fc'] = { builtin.command_history, { desc = '[C]ommand History' } },
    ['<leader>ff'] = { builtin.find_files, { desc = '[F]ind [F]iles' } },
    ['<leader>fg'] = { builtin.live_grep, { desc = 'Live [G]rep' } },
    ['<leader>fh'] = { builtin.git_status, { desc = '[H] Git Status' } },
    ['<leader>fj'] = { builtin.builtin, { desc = '[J] Telescope Functions' } },
    ['<leader>fk'] = { builtin.keymaps, { desc = 'Telescope [K]eymaps' } },
    ['<leader>fo'] = {
      function()
        builtin.oldfiles { cwd_only = true }
      end,
      { desc = 'Recent Files' }
    },
    ['<leader>fq'] = { builtin.quickfix, { desc = '[Q]uickfix' } },
    ['<leader>fr'] = { builtin.resume, { desc = '[R]esume' } },
    ['<leader>fs'] = { builtin.grep_string, { desc = 'Grep [S]tring' } },
    ['<leader>ft'] = { builtin.treesitter, { desc = '[T]reesitter' } },
    ['<leader>/'] = {
      function()
        builtin.current_buffer_fuzzy_find(themes.get_dropdown { previewer = false })
      end,
      { desc = '[/] Fuzzily search in current buffer]' }
    }
  }

  for key, val in pairs(keymaps) do
    keymap('n', key, val[1], val[2])
  end
end

M.config = function()
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
