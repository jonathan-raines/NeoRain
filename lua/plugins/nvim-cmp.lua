return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
  },
  config = function()
    vim.o.completeopt = 'menu,menuone,noselect'

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
        ['<C-y>'] = cmp.mapping.confirm { select = true },
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
  end,
  event = 'InsertEnter'
}
