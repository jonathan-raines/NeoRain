require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = {"haskell"},

  autotag = {
    enable = true,
  },
  context = {
      enable = false,
  },
  context_commentstring = {
    enable = true,
    config = {
        css = '// %s'
    }
  },
  highlight = {
      enabled = true,
  },
  indent = {
      enable = true
  },
  matchup = {
    enable = true,    -- mandatory, false will disable the whole extension
  },
  rainbow = {
      enable = false -- https://github.com/p00f/nvim-ts-rainbow
  }
}
