local M = {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets'
  },
  opts = {
    history = true,
    delete_check_events = 'TextChanged'
  },
  keys = {
    {
      '<tab>',
      function()
        return require 'luasnip'.jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>'
      end,
      expr = true, silent = true, mode = 'i',
    },
    { '<tab>', function() require 'luasnip'.jump(1) end, mode = 's' },
    { '<s-tab>', function() require 'luasnip'.jump(-1) end, mode = { 'i', 's' } },
  },
}

M.config = function()
  require 'luasnip/loaders/from_vscode'.lazy_load()
end

return M
