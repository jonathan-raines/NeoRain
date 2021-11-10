require('Comment').setup {
  {
    ---@diagnostic disable: unused-local
    pre_hook = function(ctx)
      return require('ts_context_commentstring.internal').calculate_commentstring()
    end,
  },
}
