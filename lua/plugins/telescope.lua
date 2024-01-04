return {
  'nvim-telescope/telescope.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    require 'telescope'.setup {}
  end,
  keys = {
    { '<leader><leader>', '<cmd>Telescope<CR>',                          desc = 'All Pickers' },
    { '<leader>fb',       '<cmd>Telescope buffers<CR>',                  desc = 'Buffers' },
    { '<leader>ff',       '<cmd>Telescope find_files<CR>',               desc = 'Find Files' },
    { '<leader>fo',       '<cmd>Telescope oldfiles cwd_only=v:true<CR>', desc = 'Recent Files' },
    { '<leader>fw',       '<cmd>Telescope grep_string<CR>',              desc = 'Find Word' },
    { '<leader>/',        '<cmd>Telescope live_grep<CR>',                desc = 'Live Grep' },
  }
}
