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

local opts = {
  mode = 'n', -- NORMAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local mappings = {
  ['<space>'] = 'which_key_ignore',
  ['c'] = 'which_key_ignore',
  ['C'] = 'which_key_ignore',
  ['q'] = 'which_key_ignore',
  ['w'] = 'which_key_ignore',
  ['a'] = 'which_key_ignore',
  ['A'] = 'which_key_ignore',
  b = { '<cmd>Telescope buffers theme=get_ivy<CR>', 'Buffers' },
  f = {
    name = 'Telescope',
    b = { '<cmd>Telescope buffers theme=get_ivy<CR>', 'Buffers' },
    d = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document Symbols' },
    f = { '<cmd>Telescope find_files<CR>', 'Find Files' },
    e = { '<cmd>Telescope file_browser<CR>', 'File Browser' },
    g = { '<cmd>Telescope live_grep<cr>', 'Live Grep' },
    o = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
    q = { '<cmd>Telescope quickfix<cr>', 'Open Quickfix' },
    r = { '<cmd>Telescope resume<cr>', 'Resume Last Picker' },
    s = { '<cmd>Telescope grep_string<cr>', 'Grep String' },
    t = { '<cmd>Telescope treesitter<cr>', 'Treesitter' },
    w = { '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', 'Workplace Symbols' },
  },
  ['/'] = { '<cmd>lua _CURR_BUF()<CR>', 'Search Current Buffer' },
  o = {
    name = 'Octo',
    i = {
      name = 'Issues',
      c = { '<cmd>Octo issue create<CR>', 'Create Issue' },
      l = { '<cmd>Octo issue list<CR>', 'List Issues' },
    },
    p = { '<cmd>Octo pr list<CR>', 'List Pull Requests' },
    r = {
      name = 'Review',
      s = { '<cmd>Octo review start<CR>', 'Start Review' },
      f = { '<cmd>Octo review submit<CR>', 'Submit Review' },
    },
  },
  p = {
    name = 'Packer',
    c = { '<cmd>PackerCompile<CR>', 'PackerCompile' },
    i = { '<cmd>PackerInstall<CR>', 'PackerInstall' },
    l = { '<cmd>PackerStatus<CR>', 'PackerStatus' },
    s = { '<cmd>PackerSync<CR>', 'PackerSync' },
    u = { '<cmd>PackerUpdate<CR>', 'PackerUpdate' },
  },
  t = {
    name = 'Testing',
    f = { '<cmd>TestFile<CR>', 'Run Test File' },
    l = { '<cmd>TestLast<CR>', 'Run Last Test' },
    n = { '<cmd>TestNearest<CR>', 'Run Nearest Test' },
    s = { '<cmd>TestSuite<CR>', 'Run Test Suite' },
    v = { '<cmd>TestVisit<CR>', 'Visit Test File' },
  },
}

wk.register(mappings, opts)

wk.register {
  g = {
    b = { 'Block Comment' },
    c = { 'Line Comment' },
    j = { '<cmd>DBUIToggle<CR>', 'Database' },
  },
}
