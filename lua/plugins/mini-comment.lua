return {
  'echasnovski/mini.comment',
  version = false,
  config = function()
    require 'mini.comment'.setup {}
  end,
  keys = {
    { 'gc', mode = { 'n', 'x' } },
  }
}
