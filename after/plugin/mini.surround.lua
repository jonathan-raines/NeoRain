MiniDeps.add { source = "kylechui/nvim-surround" }

MiniDeps.later(function()
  require 'nvim-surround'.setup {}
end)
