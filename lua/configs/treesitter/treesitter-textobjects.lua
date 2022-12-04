local M = {}

M.config = function()
  require 'nvim-treesitter.configs'.setup {
    textobjects = {
      lsp_interop = {
        enable = true,
        border = 'rounded',
        peek_definition_code = {
          ['<leader>df'] = { query = '@function.outer', desc = 'Peek Outer Function' },
          ['<leader>dF'] = { query = '@class.outer', desc = 'Peek Outer Class' },
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']f'] = { query = '@function.outer', desc = 'Next Outer Function Start' },
          [']]'] = { query = '@class.outer', desc = 'Next Outer Class Start' },
        },
        goto_next_end = {
          [']F'] = { query = '@function.outer', desc = 'Next Outer Function End' },
          [']['] = { query = '@class.outer', desc = 'Next Outer Function End' },
        },
        goto_previous_start = {
          ['[f'] = { query = '@function.outer', desc = 'Previous Function Start' },
          ['[['] = { '@class.outer', desc = 'Previous Class Start' },
        },
        goto_previous_end = {
          ['[F'] = { query = '@function.outer', desc = 'Previous Function End' },
          ['[]'] = { query = '@class.outer', desc = 'Previous Class end' },
        },
      },
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        keymaps = {
          ['af'] = { query = '@function.outer', desc = 'Outer Function' },
          ['if'] = { query = '@function.inner', desc = 'Inner Function' },
          ['ac'] = { query = '@class.outer', desc = 'Outer Class' },
          ['ic'] = { query = '@class.inner', desc = 'Inner Class' },
          ['al'] = { query = '@loop.outer', desc = 'Outer Loop' },
          ['il'] = { query = '@loop.inner', desc = 'Inner Loop' },
          ['aa'] = { query = '@parameter.outer', desc = 'Outer Parameter' },
          ['ia'] = { query = '@parameter.inner', desc = 'Inner Parameter' },
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = { query = '@parameter.inner', desc = 'Swap Next Parameter' },
        },
        swap_previous = {
          ['<leader>A'] = { query = '@parameter.inner', desc = 'Swap Previous Parameter' },
        },
      },
    },
  }
end

return M
