return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'

    telescope.setup {
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
        }
      }
    }
    telescope.load_extension('fzf')
  end,
  keys = {
    { '<leader><leader>', '<cmd>Telescope<CR>',                          desc = 'All Pickers' },
    { '<leader>fb',       '<cmd>Telescope buffers<CR>',                  desc = 'Buffers' },
    { '<leader>ff',       '<cmd>Telescope find_files<CR>',               desc = 'Find Files' },
    { '<leader>fo',       '<cmd>Telescope oldfiles cwd_only=v:true<CR>', desc = 'Recent Files' },
    { '<leader>/',        '<cmd>Telescope live_grep<CR>',                desc = 'Live Grep' },
  }
}
