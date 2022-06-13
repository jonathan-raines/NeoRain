local M = {}

M.config = function()
  local wk = require 'which-key'

  wk.setup {
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

  local mappings = {
    ['<space>'] = 'which_key_ignore',
    ['c'] = 'which_key_ignore',
    ['C'] = 'which_key_ignore',
    ['q'] = 'which_key_ignore',
    ['w'] = 'which_key_ignore',
    ['a'] = 'which_key_ignore',
    ['A'] = 'which_key_ignore',
    ['gg'] = { '<cmd>Neogit<CR>', 'Neogit' },
    ['h'] = 'Harpoon'
  }

  wk.register(mappings, { prefix = '<leader>' })

  wk.register {
    g = {
      b = { 'Block Comment' },
      c = { 'Line Comment' },
    },
    [']'] = {
      ['['] = { 'Next Class Outer End' },
      [']'] = { 'Next Class Outer Start' },
      q = { 'Next QuickFix Item' },
      Q = { 'Last QuickFix Item' },
      m = { 'Next Function Outer Start' },
      M = { 'Next Function Outer End' },
    },
    ['['] = {
      ['['] = { 'Previous Class Outer Start' },
      [']'] = { 'Previous Class Outer End' },
      q = { 'Previous QuickFix Item' },
      Q = { 'First QuickFix Item' },
      m = { 'Previous Function Outer Start' },
      M = { 'Previous Function Outer End' },
    },
  }
end

return M
