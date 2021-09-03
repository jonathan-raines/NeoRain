require('which-key').setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    presets = {
      operators = false, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = false, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  icons = {
    breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
    separator = '➜', -- symbol used between a key and it's label
    group = '+', -- symbol prepended to a group
  },
  window = {
    border = 'single', -- none, single, double, shadow
    position = 'bottom', -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
  },
  hidden = { '<silent>', '<cmd>', '<cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
}

local opts = {
  mode = 'n', -- NORMAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

-- explorer
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><space>', '<C-^>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<A-i>', ':ToggleTerm<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<A-i>', '<ESC>:ToggleTerm<CR>', { noremap = true, silent = true })

-- Buffers
vim.api.nvim_set_keymap('n', '<leader>c', ':bdelete<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':q!<CR>', { noremap = true, silent = true })

local mappings = {
  ['/'] = 'Comment',
  ['<space>'] = 'Switch to Last Buffer',
  ['e'] = 'Explorer',
  ['b'] = 'Buffers',
  ['w'] = 'Save',
  ['c'] = 'Close Buffer',
  ['q'] = 'QuickFix List',
  f = {
    name = 'Find',
    e = { '<cmd>Telescope file_browser<cr>', 'File Browser' },
    f = { '<cmd>Telescope find_files<CR>', 'Find Files' },
    b = { '<cmd>Telescope buffers<cr>', 'Open buffers' },
    cs = { '<cmd>Telescope colorscheme<cr>', 'Color Scheme' },
    ds = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document Symbols' },
    cb = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Search Current Buffer' },
    km = { '<cmd>Telescope keymaps<cr>', 'Find Keymaps' },
    m = { '<cmd>Telescope marks<cr>', 'Marks' },
    of = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
    ts = { '<cmd>Telescope treesitter<cr>', 'Treesitter' },
    vo = { '<cmd>Telescope vim_options<cr>', 'Find Vim Options' },
    lg = { '<cmd>Telescope live_grep<cr>', 'Live Grep' },
    gs = { '<cmd>Telescope grep_string<cr>', 'Grep String' },
    ws = { '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', 'Workplace Symbols' },
  },
  g = {
    name = 'Git',
    nh = { "<cmd>lua require'gitsigns'.next_hunk()<cr>", 'Next Hunk' },
    ph = { "<cmd>lua require'gitsigns'.prev_hunk()<cr>", 'Previous Hunk' },
    sh = { "<cmd>lua require'gitsigns'.stage_hunk()<cr>", 'Stage Hunk' },
    ush = { "<cmd>lua require'gitsigns'.undo_stage_hunk()<cr>", 'Unstage Hunk' },
    rh = { "<cmd>lua require'gitsigns'.reset_hunk()<cr>", 'Reset Hunk' },
    rb = { "<cmd>lua require'gitsigns'.reset_buffer()<cr>", 'Reset Buffer' },
    pvh = { "<cmd>lua require'gitsigns'.preview_hunk()<cr>", 'Preview Hunk' },
    b = { "<cmd>lua require'gitsigns'.blame_line()<cr>", 'Blame Line' },
  },
  h = {
    name = 'Harpoon',
    pn = { "<cmd>lua require'harpoon.mark'.add_file()<CR>", 'Add File' },
    qm = { "<cmd>lua require'harpoon.ui'.toggle_quick_menu()<CR>", 'Quick Menu' },
    f = { "<cmd>lua require'harpoon.ui'.nav_file(1)<CR>", 'Navigate to File 1' },
    g = { "<cmd>lua require'harpoon.ui'.nav_file(2)<CR>", 'Navigate to File 2' },
    h = { "<cmd>lua require'harpoon.ui'.nav_file(3)<CR>", 'Navigate to File 3' },
    j = { "<cmd>lua require'harpoon.ui'.nav_file(4)<CR>", 'Navigate to File 4' },
    t = { "<cmd>lua require'harpoon.term'.gotoTerminal(1)<CR>", 'Navigate to Terminal 1' },
    y = { "<cmd>lua require'harpoon.term'.gotoTerminal(2)<CR>", 'Navigate to Terminal 2' },
    lg = { "<cmd>lua require'harpoon.term'.sendCommand(3, 'lazygit\\n')<CR>", 'Navigate to Lazygit' },
  },
  l = {
    name = 'LSP',
    a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Action' },
    d = { '<cmd>Telescope lsp_document_diagnostics<cr>', 'Document Diagnostics' },
    f = { '<cmd>lua vim.lsp.buf.formatting()<cr>', 'Format Buffer' },
    i = { '<cmd>LspInfo<cr>', 'Info' },
    j = { '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', 'Go To Next' },
    k = { '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', 'Go To Previous' },
    l = { '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', 'Show Line Diagnostics' },
    q = { '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', 'Local List' },
    r = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename' },
    t = { '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'Type Definition' },
    w = { '<cmd>Telescope lsp_workspace_diagnostics<cr>', 'Workspace Diagnostics' },
  },
}

local wk = require 'which-key'
wk.register(mappings, opts)
