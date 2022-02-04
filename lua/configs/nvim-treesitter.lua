local configs = require 'nvim-treesitter.configs'
local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.http = {
  install_info = {
    url = 'https://github.com/NTBBloodbath/tree-sitter-http',
    files = { 'src/parser.c' },
    branch = 'main',
  },
}

configs.setup {
  ensure_installed = 'maintained',
  ignore_installed = { 'haskell' },
  autopairs = { enable = true },
  autotag = { enable = true },
  context_commentstring = { enable = true, enable_autocmd = false },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    },
  },
  indent = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
  },
}
