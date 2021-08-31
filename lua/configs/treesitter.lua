local border =  { "", "", "", " ", "", "", "", " " }

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.http = {
  install_info = {
    url = "https://github.com/NTBBloodbath/tree-sitter-http",
    files = { "src/parser.c" },
    branch = "main",
  },
}

require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  ignore_installed = {'haskell'},
  autopairs = { enable = true },
  autotag = {enable = true},
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  indent = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
  },
}
