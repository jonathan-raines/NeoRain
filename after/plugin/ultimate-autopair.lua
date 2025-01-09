MiniDeps.add { source = 'altermo/ultimate-autopair.nvim' }

MiniDeps.later(function()
  require('ultimate-autopair').setup {}
end)
