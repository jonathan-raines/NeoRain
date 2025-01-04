local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add { source = 'altermo/ultimate-autopair.nvim' }

later(function()
  require('ultimate-autopair').setup {}
end)
