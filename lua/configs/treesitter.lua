local border =  { "", "", "", " ", "", "", "", " " }

require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  ignore_installed = {'haskell'},
  autopairs = { enable = true },
  autotag = {enable = true},
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  indent = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  textobjects = {
    lsp_interop = {
      enable = true,
      border = border,
      peek_definition_code = {
        ["df"] = "@function.outer",
        ["dF"] = "@class.outer",
      }
    },
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['ab'] = '@block.outer',
        ['ib'] = '@block.inner',
        ['ai'] = '@conditional.outer',
        ['ii'] = '@conditional.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['glc'] = '@class.outer',
        ['glf'] = '@function.outer',
        ['glp'] = '@parameter.inner',
      },
      swap_previous = {
        ['ghc'] = "@class.outer",
        ['ghf'] = "@function.outer",
        ['ghp'] = "@parameter.inner",
      },
    },
  },
}
