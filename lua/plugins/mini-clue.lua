return {
  'echasnovski/mini.clue',
  config = function()
    local miniclue = require('mini.clue')
    miniclue.setup({
      triggers = {
        -- Mini-Bracketed triggers
        { mode = 'n', keys = '[' },
        { mode = 'n', keys = ']' },
        { mode = 'x', keys = '[' },
        { mode = 'x', keys = ']' },

        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
      },

      clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers({ show_contents = false }),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
        { mode = 'n', keys = '<Leader>f',  desc = '+Find' },
        { mode = 'n', keys = '<Leader>F',  desc = '+Find' },
        { mode = 'n', keys = '<Leader>h',  desc = '+Git' },
        { mode = 'n', keys = '<Leader>ht', desc = '+Toggle' },
        { mode = 'n', keys = '<Leader>l',  desc = '+Lsp' },
        { mode = 'n', keys = '<Leader>t',  desc = '+Test' },
        { mode = 'n', keys = '<Leader>g',  desc = '+Grapple' },
      },

      window = {
        config = {
          width = 'auto',
        },
        delay = 0,
      },
    })
  end,
  version = false,
  event = "VeryLazy"
}
