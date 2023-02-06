local M = {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
    'nvim-telescope/telescope-file-browser.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  cmd = 'Telescope'
}

M.init = function()
  local keymap = vim.keymap.set
  local builtin = require 'telescope.builtin'

  local keymaps = {
    ['<leader>b'] = { builtin.buffers, { desc = 'Buffers' } },
    ['<leader>fc'] = { builtin.command_history, { desc = 'Command History' } },
    ['<leader>fe'] = {
      function()
        vim.cmd.Telescope { 'file_browser', 'path=%:p:h' }
      end, { desc = 'File Browser' }
    },
    ['<leader>ff'] = { builtin.find_files, { desc = 'Find Files' } },
    ['<leader>fg'] = { builtin.live_grep, { desc = 'Live Grep' } },
    ['<leader>fh'] = { builtin.git_status, { desc = 'Git Status' } },
    ['<leader>fj'] = { builtin.builtin, { desc = 'Functions' } },
    ['<leader>fk'] = { builtin.keymaps, { desc = 'Keymaps' } },
    ['<leader>fo'] = {
      function()
        builtin.oldfiles { cwd_only = true }
      end,
      { desc = 'Recent Files' }
    },
    ['<leader>fq'] = { builtin.quickfix, { desc = 'Quickfix' } },
    ['<leader>fr'] = { builtin.resume, { desc = 'Resume' } },
    ['<leader>fs'] = { builtin.grep_string, { desc = 'Grep String' } },
    ['<leader>ft'] = { builtin.treesitter, { desc = 'Treesitter' } },
    ['<leader>/'] = {
      function()
        builtin.current_buffer_fuzzy_find(require 'telescope.themes'.get_dropdown { previewer = false })
      end,
      { desc = 'Fuzzy Search Buffer' }
    }
  }

  for key, val in pairs(keymaps) do
    keymap('n', key, val[1], val[2])
  end
end

M.config = function()
  local actions = require 'telescope.actions'

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
        i = {},
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
    pickers = {
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
  }

  require 'telescope'.load_extension 'fzf'
  require 'telescope'.load_extension 'file_browser'
end

return M
