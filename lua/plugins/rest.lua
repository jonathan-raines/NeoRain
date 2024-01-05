return {
  "rest-nvim/rest.nvim",
  dependencies = { { "nvim-lua/plenary.nvim" } },
  config = function()
    require("rest-nvim").setup {}
  end,
  commit = "8b62563",
  keys = {
    { '<leader>rr', '<Plug>RestNvim',        desc = '[REST] Run curl request' },
    { '<leader>rp', '<Plug>RestNvimPreview', desc = '[REST] Preview curl command' },
    { '<leader>rl', '<Plug>RestNvimLast',    desc = '[REST] Run last curl request' }
  },
  ft = { 'http' }
}
