return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require 'toggleterm'.setup {
      open_mapping = [[<c-\>]],
      direction = 'float'
    }

    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true })

    function _G_lazygit_toggle()
      lazygit:toggle()
    end
  end,
  keys = {
    "<c-\\>",
    { "<leader>lg", "<cmd>lua _G_lazygit_toggle()<CR>", desc = 'lazygit' }
  }
}
