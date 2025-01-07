--  ╭─────────────────────────────────────────────────────────╮
--  │                     Neovim Options                      │
--  ╰─────────────────────────────────────────────────────────╯
local opt          = vim.opt

-- Global statusline
opt.laststatus     = 3

-- Enable relative line numbers
opt.number         = true
opt.relativenumber = true

-- Set tabs to 2 spaces
opt.tabstop        = 2
opt.expandtab      = true

-- Enable auto indenting and set it to spaces
opt.smartindent    = true
opt.shiftwidth     = 2
--
-- Negative uses shiftwidth value
opt.softtabstop    = -1

-- Enable incremental searching
opt.incsearch      = true

-- Enable incremental searching
opt.hlsearch       = false

-- Preview incremental substitute
opt.inccommand     = 'split'

-- Disable text wrap
opt.wrap           = false

-- Better splitting
opt.splitbelow     = true
opt.splitright     = true

-- Enable ignorecase + smartcase for better searching
opt.ignorecase     = true
opt.smartcase      = true

-- Set completeopt to have a better completion experience
opt.completeopt    = { "menuone", "noselect" }

-- Enable persistent undo history
opt.undofile       = true
opt.undodir        = os.getenv 'HOME' .. '/.vim/undodir'

-- Enable the sign column to prevent the screen from jumping
opt.signcolumn     = "yes"

-- Set fold settings
opt.foldexpr       = 'v:lua.vim.treesitter.foldexpr()'
opt.foldmethod     = 'expr'
opt.foldtext       = ''

-- Display all folds except top ones
opt.foldlevel      = 99

-- Always keep 8 lines above/below cursor unless at start/end of file
opt.scrolloff      = 8
opt.sidescrolloff  = 8

-- Place a column line
opt.textwidth      = 100

-- Disable swapfile
opt.autoread       = true
opt.swapfile       = false

--Disable showing mode in command line
opt.showmode       = false

-- Decrease update time
opt.updatetime     = 250

-- Don't have `o` add a comment
opt.formatoptions:remove "o"

-- Dash as part of the word
opt.iskeyword:append("-")

-- Use special characters to represent things like tabs or trailing spaces
opt.list = true
opt.listchars:append {
  tab = "┊ ",
  leadmultispace = "┊ ", -- or "│ "
  trail = "␣",
  nbsp = "⍽",
  extends = "»",
  precedes = "«",
}

--  ╭─────────────────────────────────────────────────────────╮
--  │                     Global Options                      │
--  ╰─────────────────────────────────────────────────────────╯
vim.g.health = { style = 'float' }
