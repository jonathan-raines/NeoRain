return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require('mini.animate').setup({
        scroll = {
          enable = false,
        }
      })

      -- require('mini.completion').setup({
      --   window = {
      --     info = { border = 'double' },
      --     signature = { border = 'double' },
      --   },
      -- })

      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })

      -- require('mini.pairs').setup()
    end
  }
}
