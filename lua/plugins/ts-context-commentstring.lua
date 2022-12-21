local M = {
  'JoosepAlviste/nvim-ts-context-commentstring',
  lazy = true
}

M.config = function()
  require 'nvim-treesitter.configs'.setup {
    context_commentstring = { enable = true }
  }
end

return M
