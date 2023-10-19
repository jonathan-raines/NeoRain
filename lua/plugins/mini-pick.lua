return {
  'echasnovski/mini.pick',
  config = function()
    require('mini.pick').setup {
      options = {
        use_cache = true
      }
    }
  end,
  keys = {
    { '<leader>fb', '<cmd>Pick buffers<CR>',                desc = 'Find Buffers' },
    { '<leader>ff', '<cmd>Pick files<CR>',                  desc = 'Find Files' },
    { '<leader>/',  '<cmd>Pick grep_live<CR>',              desc = 'Find String' },
    { '<leader>fs', '<cmd>Pick grep<CR>',                   desc = 'Find String' },
    { '<leader>fw', '<cmd>Pick grep pattern="<cword>"<CR>', desc = 'Find Word' },
  },
  enabled = false
}
