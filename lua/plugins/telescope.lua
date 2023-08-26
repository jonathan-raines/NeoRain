return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    },
  },
  config = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'

    telescope.setup {
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
          theme = 'dropdown',
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
    telescope.load_extension('fzf')
  end,
  keys = {
    { '<leader>Fa', '<cmd>Telescope<CR>',                           desc = 'Pickers' },
    { '<leader>Fb', '<cmd>Telescope buffers<CR>',                   desc = 'Buffers' },
    { '<leader>Fd', '<cmd>Telescope lsp_definitions<CR>',           desc = 'Definitions' },
    { '<leader>Ff', '<cmd>Telescope find_files<CR>',                desc = 'Files' },
    { '<leader>Fg', '<cmd>Telescope live_grep<CR>',                 desc = 'Grep' },
    { '<leader>Fh', '<cmd>Telescope git_status<CR>',                desc = 'Git' },
    { '<leader>Fo', '<cmd>Telescope oldfiles cwd_only=v:true<CR>',  desc = 'Recent' },
    { '<leader>Fq', '<cmd>Telescope quickfix<CR>',                  desc = 'Quickfix' },
    { '<leader>Fr', '<cmd>Telescope lsp_references<CR>',            desc = 'References' },
    { '<leader>Fw', '<cmd>Telescope grep_string<CR>',               desc = 'Grep word' },
    { '<leader>F/', '<cmd>Telescope current_buffer_fuzzy_find<CR>', desc = 'Current Buffer' },
    { '<leader>Fs', '<cmd>Telescope lsp_document_symbols<CR>',      desc = 'Document Symbols' },
    { '<leader>FS', '<cmd>Telescope lsp_workspace_symbols<CR>',     desc = 'Workspace Symbols' },
  },
  cmd = 'Telescope'
}
