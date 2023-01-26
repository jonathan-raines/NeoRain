local M = {
  'SmiteshP/nvim-navic',
  dependencies = 'neovim/nvim-lspconfig',
  enabled = false
}

M.config = function()
  vim.g.navic_silence = true
  require 'nvim-navic'.setup { separator = ' ', highlight = true, depth_limit = 5 }
end

return M
