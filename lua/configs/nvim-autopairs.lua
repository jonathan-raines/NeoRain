local npairs = require 'nvim-autopairs'

npairs.setup {
  check_ts = true,
  disable_filetype = { 'TelescopePrompt', 'vim' },
  fast_wrap = {
    map = '<M-e>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
    offset = 0, -- Offset from pattern match
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'PmenuSel',
    highlight_grey = 'LineNr',
  },
  ts_config = {
    lua = { 'string', 'source' }, -- it will not add pair on that treesitter node
    javascript = { 'string', 'template_string' },
    java = false, -- don't check treesitter on java
  },
}

npairs.add_rules(require 'nvim-autopairs.rules.endwise-lua')
npairs.add_rules(require 'nvim-autopairs.rules.endwise-ruby')

-- If you want insert `(` after select function or method item
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
local cmp = require 'cmp'

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done { map_char = { tex = '' } })
