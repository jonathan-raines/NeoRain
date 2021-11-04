local npairs = require 'nvim-autopairs'
local Rule = require 'nvim-autopairs.rule'

npairs.setup {
  check_ts = true,
  fast_wrap = {},
  ts_config = {
    lua = { 'string' }, -- it will not add pair on that treesitter node
    javascript = { 'template_string' },
    java = false, -- don't check treesitter on java
  },
}

local ts_conds = require 'nvim-autopairs.ts-conds'

-- press % => %% is only inside comment or string
npairs.add_rules {
  Rule('%', '%', 'lua'):with_pair(ts_conds.is_ts_node { 'string', 'comment' }),
  Rule('$', '$', 'lua'):with_pair(ts_conds.is_not_ts_node { 'function' }),
}

npairs.add_rules(require 'nvim-autopairs.rules.endwise-lua')
npairs.add_rules(require 'nvim-autopairs.rules.endwise-ruby')

require('nvim-autopairs.completion.cmp').setup {
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = true, -- automatically select the first item
}
