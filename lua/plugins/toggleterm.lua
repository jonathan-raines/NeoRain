return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require 'toggleterm'.setup {
      open_mapping = [[<c-\>]],
      direction = 'float',
      float_opts = {
        height = math.floor(vim.o.lines * 0.90),
        width = math.floor(vim.o.columns * 0.90),
      }
    }

    local Terminal = require('toggleterm.terminal').Terminal

    function _G_lazygit_toggle()
      Terminal:new({ cmd = "lazygit", hidden = true }):toggle()
    end
  end,
  keys = {
    "<c-\\>",
    { "<leader>hl", "<cmd>lua _G_lazygit_toggle()<CR>", desc = 'Lazygit' }
  }
}
