return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    -- {
    --   "L3MON4D3/LuaSnip",
    --   dependencies = {
    --     "rafamadriz/friendly-snippets",
    --   },
    -- },
  },
  config = function()
    local cmp = require 'cmp'
    -- local luasnip = require "luasnip"
    -- require("luasnip/loaders/from_vscode").lazy_load()

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
      Folder = '  ',
      Function = "󰊕 ",
      Interface = ' ',
      Keyword = '  ',
      Method = ' ',
      Module = '  ',
      Namespace = ' ',
      Number = ' ',
      Object = ' ',
      Operator = ' ',
      Package = ' ',
      Property = ' ',
      Reference = '  ',
      Snippet = ' ',
      String = ' ',
      Struct = '  ',
      Text = ' ',
      TypeParameter = ' ',
      Unit = ' ',
      Value = '  ',
      Variable = '  ',
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
          vim.snippet.expand(args.body:gsub('${(%d):(.-)}', '$%1'))
          -- require 'luasnip'.lsp_expand(args.body)
        end
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
