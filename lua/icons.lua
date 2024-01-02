local M = {}

--- Diagnostic severities.
M.diagnostics = {
  ERROR = '',
  HINT = '',
  INFO = '',
  WARN = '',
}

--- For folding.
M.arrows = {
  down = '',
  left = '',
  right = '',
  up = '',
}

--- LSP symbol kinds.
M.symbol_kinds = {
  Array = ' ',
  Boolean = ' ',
  Class = ' ',
  Color = ' ',
  Constant = ' ',
  Constructor = ' ',
  Enum = ' ',
  EnumMember = ' ',
  Event = ' ',
  Field = ' ',
  File = ' ',
  Folder = '',
  -- Folder = '󰉋',
  Function = "󰊕 ",
  Interface = ' ',
  Keyword = '  ',
  Method = ' ',
  Module = '  ',
  Namespace = ' ',
  Number = ' ',
  Object = ' ',
  Operator = ' ',
  Package = ' ',
  Property = ' ',
  Reference = '  ',
  Snippet = ' ',
  String = ' ',
  Struct = '  ',
  Text = ' ',
  TypeParameter = ' ',
  Unit = ' ',
  Value = '  ',
  Variable = '  ',
}


--- Shared icons that don't really fit into a category.
M.misc = {
  alpha = "",
  bug = '',
  git = '',
  lazy = "󰒲",
  oil = "󱐋",
  search = '',
  telescope = "󰭎 ",
  vertical_bar = '│',
}

return M
