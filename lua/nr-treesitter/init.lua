require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true
  },
  matchup = {
    enable = true,              -- mandatory, false will disable the whole extension
    -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
  },
}


