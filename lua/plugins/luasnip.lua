local M = { 'L3MON4D3/LuaSnip' }

M.lazy = true

M.dependencies = 'saadparwaiz1/cmp_luasnip'

M.config = function()
  require 'luasnip/loaders/from_vscode'.lazy_load()
end

return M
