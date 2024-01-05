-- Enable relative line numbers
vim.opt.number         = true
vim.opt.relativenumber = true

-- Set tabs to 2 spaces
vim.opt.tabstop        = 2
vim.opt.expandtab      = true

-- Negative uses shiftwidth value
vim.opt.softtabstop    = -1

-- Enable auto indenting and set it to spaces
vim.opt.smartindent    = true
vim.opt.shiftwidth     = 2

-- Enable incremental searching
vim.opt.incsearch      = true
vim.opt.hlsearch       = false

-- Preview incremental substitute
vim.opt.inccommand     = 'split'

-- Disable text wrap
vim.opt.wrap           = false

-- Better splitting
vim.opt.splitbelow     = true
vim.opt.splitright     = true

-- Enable ignorecase + smartcase for better searching
vim.opt.ignorecase     = true
vim.opt.smartcase      = true

-- Set completeopt to have a better completion experience
vim.opt.completeopt    = { "menuone", "noselect" }

-- Enable persistent undo history
vim.opt.undofile       = true
vim.opt.undodir        = os.getenv 'HOME' .. '/.vim/undodir'

-- Enable the sign column to prevent the screen from jumping
vim.opt.signcolumn     = "yes"

-- Set fold settings
vim.opt.foldexpr       = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldmethod     = 'expr'
vim.opt.foldtext       = ''

-- Display all folds except top ones
vim.opt.foldlevel      = 99

-- Always keep 8 lines above/below cursor unless at start/end of file
vim.opt.scrolloff      = 8
vim.opt.sidescrolloff  = 8

-- Place a column line
vim.opt.colorcolumn    = "+1"
vim.opt.textwidth      = 100

-- Improve comment editing
vim.opt.formatoptions  = 'rqnl1j'

-- Global Statusline
vim.opt.laststatus     = 3

-- List Characters
vim.opt.list           = true
vim.opt.listchars      = { extends = '.', precedes = '|', tab = "⇥ ", leadmultispace = "│ ", trail = "␣", nbsp = "⍽" }

-- Disable swapfile
vim.opt.swapfile       = false

-- Disable vim help buffer on opening
vim.opt.shortmess:append 'cI'

--Disable showing mode in command line
vim.opt.showmode = false

-- Treat dash separated words as a word text object
-- vim.opt.iskeyword:append('-')
