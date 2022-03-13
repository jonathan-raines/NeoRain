local wk = require 'which-key'

wk.setup {
  plugins = {
    marks = true,
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    presets = {
      operators = false, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = false, -- default bindings on <c-w>
      nav = false, -- misc bindings to work with windows
    },
  },
  key_labels = {
    ['<space>'] = 'SPC',
    ['<CR>'] = 'RET',
    ['<tab>'] = 'TAB',
  },
  window = {
    border = 'rounded', -- none, single, double, shadow
  },
  layout = {
    spacing = 8, -- spacing between columns
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
}

local mappings = {
  ['<space>'] = 'which_key_ignore',
  ['c'] = 'which_key_ignore',
  ['C'] = 'which_key_ignore',
  ['q'] = 'which_key_ignore',
  ['w'] = 'which_key_ignore',
  ['a'] = 'which_key_ignore',
  ['A'] = 'which_key_ignore',
  f = {
    name = 'Telescope',
    b = { 'Buffers' },
    d = { 'Document Symbols' },
    f = { 'Find Files' },
    e = { 'File Browser' },
    g = { 'Live Grep' },
    o = { 'Open Recent File' },
    q = { 'Open Quickfix' },
    r = { 'Resume Last Picker' },
    s = { 'Grep String' },
    t = { 'Treesitter' },
    w = { 'Workplace Symbols' },
  },
  ['/'] = { 'Search Current Buffer' },
  o = {
    name = 'Octo',
    i = {
      name = 'Issues',
      c = { 'Create Issue' },
      l = { 'List Issues' },
    },
    p = { 'List Pull Requests' },
    r = {
      name = 'Review',
      s = { 'Start Review' },
      f = { 'Submit Review' },
    },
  },
  p = {
    name = 'Packer',
    c = { 'PackerCompile' },
    i = { 'PackerInstall' },
    l = { 'PackerStatus' },
    s = { 'PackerSync' },
    u = { 'PackerUpdate' },
  },
  t = {
    name = 'Testing',
    f = { 'Run Test File' },
    l = { 'Run Last Test' },
    n = { 'Run Nearest Test' },
    s = { 'Run Test Suite' },
    v = { 'Visit Test File' },
  },
}

wk.register(mappings, { prefix = '<leader>' })

wk.register {
  g = {
    b = { 'Block Comment' },
    c = { 'Line Comment' },
  },
}
