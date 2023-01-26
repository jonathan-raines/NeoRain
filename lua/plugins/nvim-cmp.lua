local M = {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
  },
  event = 'InsertEnter'
}

M.config = function()
  vim.o.completeopt = 'menuone,noselect'

  local cmp = require 'cmp'

  local kinds = {
    Array = ' ',
    Boolean = ' ',
    Class = ' ',
    Color = ' ',
    Constant = ' ',
    Constructor = ' ',
    Enum = ' ',
    EnumMember = ' ',
    Event = ' ',
    Field = ' ',
    File = ' ',
    Folder = ' ',
    Function = ' ',
    Interface = ' ',
    Key = ' ',
    Keyword = ' ',
    Method = ' ',
    Module = ' ',
    Namespace = ' ',
    Null = 'ﳠ ',
    Number = ' ',
    Object = ' ',
    Operator = ' ',
    Package = ' ',
    Property = ' ',
    Reference = ' ',
    Snippet = ' ',
    String = ' ',
    Struct = ' ',
    Text = ' ',
    TypeParameter = ' ',
    Unit = ' ',
    Value = ' ',
    Variable = ' ',
  }

  cmp.setup {
    experimental = {
      ghost_text = true,
    },
    formatting = {
      -- fields = { 'kind', 'abbr', 'menu' },
      -- format = function(entry, vim_item)
      --   vim_item.kind = string.format('%s %s', kinds[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      --   vim_item.menu = ({
      --     buffer = '[Buffer]',
      --     luasnip = '[Snippet]',
      --     nvim_lsp = '[LSP]',
      --     path = '[Path]',
      --     nvim_lua = '[NVIM_LUA]',
      --   })[entry.source.name]
      --   return vim_item
      -- end,
      format = function(_, item)
        if kinds[item.kind] then
          item.kind = kinds[item.kind] .. item.kind
        end
        return item
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    snippet = {
      expand = function(args)
        require 'luasnip'.lsp_expand(args.body)
      end,
    },
    sources = cmp.config.sources {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'nvim_lua' },
    },
  }
end

return M
