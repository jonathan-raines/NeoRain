local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add { source = 'projekt0n/github-nvim-theme' }
add { source = 'navarasu/onedark.nvim' }

now(function()
  require 'github-theme'.setup {}
  require 'onedark'.setup { transparent = true }
end)

now(function()
  vim.cmd.colorscheme 'onedark'
end)
