return {
  "jinh0/eyeliner.nvim",
  config = function()
    require 'eyeliner'.setup {
      highlight_on_key = true,
      dim = true,
      bold = true
    }
  end,
  keys = { 'f', 'F', 't', 'T' }
}
