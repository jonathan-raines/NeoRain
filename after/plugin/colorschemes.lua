local add, now = MiniDeps.add, MiniDeps.now

add { source = 'projekt0n/github-nvim-theme' }
add { source = 'sainnhe/sonokai' }
add { source = 'folke/tokyonight.nvim' }

now(function()
  require 'github-theme'.setup {}
  require 'tokyonight'.setup {}

  vim.g.sonokai_better_performance = 1
end)

now(function()
  vim.cmd.colorscheme 'github_dark_default'
end)
