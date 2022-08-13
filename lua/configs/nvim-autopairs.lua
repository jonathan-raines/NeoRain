local npairs = require 'nvim-autopairs'
local Rule = require 'nvim-autopairs.rule'

npairs.setup {
  fast_wrap = {},
  check_ts = true,
  ts_config = {
    lua = { 'string' }, -- it will not add a pair on that treesitter node
    javascript = { 'template_string' },
    java = false, -- don't check treesitter on java
  }
}

npairs.add_rules(require 'nvim-autopairs.rules.endwise-lua')
npairs.add_rules(require 'nvim-autopairs.rules.endwise-ruby')

local cmp_ok, cmp = pcall(require, 'cmp')
if cmp_ok then
  cmp.event:on('confirm_done', require 'nvim-autopairs.completion.cmp'.on_confirm_done())
end
