return {
  'folke/which-key.nvim',
  init = function()
    require 'which-key'.register({
          ['a'] = 'which_key_ignore',
          ['A'] = 'which_key_ignore',
          ['C'] = 'which_key_ignore',
          ['L'] = 'which_key_ignore',
          ['s'] = 'which_key_ignore',
          ['m'] = 'which_key_ignore',
      g = 'Git',
      h = 'Grapple',
    }, { prefix = '<leader>' })
  end,
  config = function()
    require 'which-key'.setup {
      plugins = {
        marks = true,
        registers = true,      -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        presets = {
          operators = false,   -- adds help for operators like d, y, ...
          motions = false,     -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = false,     -- default bindings on <c-w>
          nav = false,         -- misc bindings to work with windows
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
        spacing = 6,          -- spacing between columns
      },
      ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    }
  end
}
