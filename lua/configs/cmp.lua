local cmp = require 'cmp'
local luasnip = require 'luasnip'

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

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
end

cmp.setup {
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
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.api.nvim_feedkeys(t '<C-n>', 'n', true)
      elseif check_back_space() then
        vim.api.nvim_feedkeys(t '<Tab>', 'n', true)
      elseif luasnip.expand_or_jumpable() then
        vim.api.nvim_feedkeys(t '<Plug>luasnip-expand-or-jump', '', true)
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.api.nvim_feedkeys(t '<C-p>', 'n', true)
      elseif luasnip.jumpable(-1) then
        vim.api.nvim_feedkeys(t '<Plug>luasnip-jump-prev', 'n', true)
      elseif luasnip.expand_or_jumpable() then
        vim.api.nvim_feedkeys(t '<Plug>luasnip-expand-or-jump', '', true)
      else
        fallback()
      end
    end,
  },

  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
  },
}
