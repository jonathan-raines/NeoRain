return {
  'folke/which-key.nvim',
  config = function()
    require 'which-key'.setup {
      plugins = {
        marks = true,
        registers = true,      -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        presets = {
          operators = true,    -- adds help for operators like d, y, ...
          motions = true,      -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true,      -- default bindings on <c-w>
          nav = true,          -- misc bindings to work with windows
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
