return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
    'nvim-telescope/telescope-file-browser.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'otavioschwanck/telescope-alternate',
    'LukasPietzschmann/telescope-tabs',
    'debugloop/telescope-undo.nvim',
  },
  keys = {
    { '<leader>/',  '<cmd>Telescope current_buffer_fuzzy_find<CR>',          desc = 'Fuzzy Search Buffer' },
    { '<leader>b',  '<cmd>Telescope buffers<CR>',                            desc = 'Buffers' },
    { '<leader>fa', '<cmd>Telescope telescope-alternate alternate_file<CR>', desc = 'Alternate File' },
    { '<leader>fd', '<cmd>Telescope diagnostics<CR>',                        desc = 'Diagnostics' },
    { '<leader>fe', '<cmd>Telescope file_browser path=%:p:h<CR>',            desc = 'File Browser' },
    { '<leader>ff', '<cmd>Telescope find_files<CR>',                         desc = 'Find Files' },
    { '<leader>fg', '<cmd>Telescope live_grep<CR>',                          desc = 'Live Grep' },
    { '<leader>fh', '<cmd>Telescope git_status<CR>',                         desc = 'Git Status' },
    { '<leader>fj', '<cmd>Telescope jumplist<CR>',                           desc = 'Jumplist' },
    { '<leader>fm', '<cmd>Telescope marks<CR>',                              desc = 'Marks' },
    { '<leader>fp', '<cmd>Telescope<CR>',                                    desc = 'Telescope Functions' },
    { '<leader>fq', '<cmd>Telescope quickfix<CR>',                           desc = 'Quickfix' },
    { '<leader>fo', '<cmd>Telescope oldfiles<CR>',                           desc = 'Old Files' },
    { '<leader>fr', '<cmd>Telescope resume<CR>',                             desc = 'Resume' },
    { '<leader>fs', '<cmd>Telescope grep_string<CR>',                        desc = 'Grep String' },
    { '<leader>ft', '<cmd>Telescope telescope-tabs list_tabs<CR>',           desc = 'Tabs' },
  },
  config = function()
    local actions = require 'telescope.actions'

    require 'telescope'.setup {
      defaults = {
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
      },
      pickers = {
        buffers = {
          initial_mode = 'normal',
          theme = 'dropdown',
          sort_mru = true,
          mappings = {
            i = {
              ['<A-d>'] = actions.delete_buffer,
            },
            n = {
              ['d'] = actions.delete_buffer,
              ['q'] = actions.close
            }
          },
        },
        current_buffer_fuzzy_find = {
          previewer = false,
        },
        find_files = {
          hidden = true,
          file_ignore_patterns = { '.git/' },
        },
        git_files = {
          hidden = true,
          show_untracked = true,
        },
        oldfiles = {
          hidden = true,
          cwd_only = true
        },
      },
      extensions = {
        ['telescope-alternate'] = {
          mappings = {},
          presets = { 'rails', 'rspec' }
        },
        ['telescope-tabs'] = {
          show_preview = false
        },
      },
    }

    require 'telescope'.load_extension 'fzf'
    require 'telescope'.load_extension 'file_browser'
    require 'telescope'.load_extension 'telescope-alternate'
    require 'telescope'.load_extension 'telescope-tabs'
    require 'telescope'.load_extension 'undo'
  end,
  cmd = 'Telescope'
}
