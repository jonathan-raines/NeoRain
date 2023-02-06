return {
  'folke/which-key.nvim',
  init = function()
    require 'which-key'.register({
      ['1'] = 'which_key_ignore',
      ['2'] = 'which_key_ignore',
      ['3'] = 'which_key_ignore',
      ['4'] = 'which_key_ignore',
      ['a'] = 'which_key_ignore',
      ['A'] = 'which_key_ignore',
      ['C'] = 'which_key_ignore',
      ['L'] = 'which_key_ignore',
      ['s'] = 'which_key_ignore',
      f = 'Telescope',
      g = 'Git',
      h = 'Grapple',
      j = 'Terminal',
      t = 'Test',
    }, { prefix = '<leader>' })
  end,
  config = function()
    require 'which-key'.setup {
      plugins = {
        marks = true,
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        presets = {
          operators = false, -- adds help for operators like d, y, ...
          motions = false, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = false, -- default bindings on <c-w>
          nav = false, -- misc bindings to work with windows
        },
      },
      key_labels = {
        ['<space>'] = 'SPC',
        ['<CR>'] = 'RET',
        ['<tab>'] = 'TAB',
      },
      window = {
        border = 'rounded', -- none, single, double, shadow
      },
      layout = {
        spacing = 8, -- spacing between columns
      },
      ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    }
  end
}
