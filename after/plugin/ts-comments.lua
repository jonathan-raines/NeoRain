local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add { source = "folke/ts-comments.nvim" }

later(function()
  require 'ts-comments'.setup {}
end)
