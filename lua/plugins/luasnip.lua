local M = {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'saadparwaiz1/cmp_luasnip',
    {
      'rafamadriz/friendly-snippets',
      config = function()
        require 'luasnip.loaders.from_vscode'.lazy_load()
      end
    }
  },
  lazy = true
}

M.config = function()
  require 'luasnip/loaders/from_vscode'.lazy_load()
end

return M
