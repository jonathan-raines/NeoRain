local cmp = require 'cmp'

local icons = {
  Text = '',
  Method = '',
  Function = '',
  Constructor = '',
  Field = 'ﰠ',
  Variable = '',
  Class = 'ﴯ',
  Interface = '',
  Module = '',
  Property = 'ﰠ',
  Unit = '塞',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = 'פּ',
  Event = '',
  Operator = '',
  TypeParameter = '',
}

cmp.setup {
  documentation = {
    border = 'single',
    winhighlight = 'FloatBorder:FloatBorder,Normal:Normal',
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format('%s %s', icons[vim_item.kind], vim_item.kind)

      vim_item.menu = ({
        nvim_lsp = '[LSP]',
        nvim_lua = '[LUA]',
        buffer = '[BUF]',
      })[entry.source.name]

      return vim_item
    end,
  },

  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-y>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ['<C-Space>'] = cmp.mapping.complete(),
    -- ['<Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif luasnip.expand_or_jumpable() then
    --     luasnip.expand_or_jump()
    --   elseif has_words_before() then
    --     cmp.complete()
    --   else
    --     fallback()
    --   end
    -- end, {
    --   'i',
    --   's',
    -- }),
    --
    -- ['<S-Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif luasnip.jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end, {
    --   'i',
    --   's',
    -- }),
  },

  sources = {
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'buffer', keyword_length = 5 },
  },

  experimental = {
    native_menu = false,
    ghost_text = true,
  },
}
