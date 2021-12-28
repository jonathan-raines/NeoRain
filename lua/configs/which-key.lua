local status_ok, wk = pcall(require, 'which-key')
if not status_ok then
  return
end

local function curr_buf()
  local opt = require('telescope.themes').get_ivy()
  require('telescope.builtin').current_buffer_fuzzy_find(opt)
end

wk.setup {
  plugins = {
    marks = true,
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    presets = {
      operators = false, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = false, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
    },
  },
  key_labels = {
    ['<space>'] = 'SPC',
    ['<CR>'] = 'RET',
    ['<tab>'] = 'TAB',
  },
  window = {
    border = 'single', -- none, single, double, shadow
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
  ['e'] = 'which_key_ignore',
  ['q'] = 'which_key_ignore',
  ['Q'] = 'which_key_ignore',
  ['w'] = 'which_key_ignore',
  ['W'] = 'which_key_ignore',
  f = {
    name = 'Telescope',
    b = { '<cmd>Telescope buffers theme=get_ivy<CR>', 'Buffers' },
    d = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document Symbols' },
    f = { '<cmd>Telescope find_files<CR>', 'Find Files' },
    e = { "<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<cr>", 'File Browser' },
    g = { '<cmd>Telescope live_grep<cr>', 'Live Grep' },
    o = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
    s = { '<cmd>Telescope grep_string<cr>', 'Grep String' },
    t = { '<cmd>Telescope treesitter<cr>', 'Treesitter' },
    w = { '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', 'Workplace Symbols' },
  },
  ['/'] = { curr_buf, 'Search Current Buffer' },
  o = {
    name = 'Octo',
    i = {
      name = 'Issues',
      c = { ':Octo issue create<CR>', 'Create Issue' },
      l = { ':Octo issue list<CR>', 'List Issues' },
    },
    p = { ':Octo pr list<CR>', 'List Pull Requests' },
    r = {
      name = 'Review',
      s = { ':Octo review start<CR>', 'Start Review' },
      f = { ':Octo review submit<CR>', 'Submit Review' },
    },
  },
  p = {
    name = 'Packer',
    c = { ':PackerCompile<CR>', 'PackerCompile' },
    s = { ':PackerSync<CR>', 'PackerSync' },
    t = { ':StartupTime<CR>', 'Startup Time' },
  },
  t = {
    name = 'Testing',
    f = { ':TestFile<CR>', 'Run Test File' },
    l = { ':TestLast<CR>', 'Run Last Test' },
    n = { ':TestNearest<CR>', 'Run Nearest Test' },
    s = { ':TestSuite<CR>', 'Run Test Suite' },
    v = { ':TestVisit<CR>', 'Visit Test File' },
  },
}

wk.register(mappings, opts)
