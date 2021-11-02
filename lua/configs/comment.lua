require('Comment').setup {
  {
    ---@param ctx Ctx
    pre_hook = function(ctx)
      return require('ts_context_commentstring.internal').calculate_commentstring()
    end,
  },
}
