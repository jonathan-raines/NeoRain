local options = {
  backup = false, -- creates a backup file
  clipboard = 'unnamedplus', -- allows neovim to access the system clipboard
  cmdheight = 2, -- more space in the neovim command line for displaying messages
  colorcolumn = '100', -- creates column at number specified
  completeopt = { 'menuone', 'noselect' }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  cursorline = true, -- highlight the current line
  expandtab = true, -- convert tabs to spaces
  fileencoding = 'utf-8', -- the encoding written to a file
  foldexpr = 'nvim_treesitter#foldexpr()',
  foldlevelstart = 99,
  foldmethod = 'expr',
  hlsearch = false, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  mouse = 'a', -- allow the mouse to be used in neovim
  number = true,
  numberwidth = 4, -- set number column width to 2 {default 4}
  pumheight = 10, -- pop up menu height
  relativenumber = true,
  scrolloff = 8,
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  sidescrolloff = 8,
  signcolumn = 'yes', -- always show the sign column, otherwise it would shift the text each time
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  tabstop = 2, -- insert 2 spaces for a tab
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion (4000ms default)
  wildignore = '**/node_modules/*, **/.git/*',
  wildmode = 'longest:full,full',
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  wrap = false, -- display lines as one long line
}

vim.opt.shortmess:append 'cI'

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Highlight on yank
vim.api.nvim_exec(
  [[
    augroup YankHighlight
      autocmd!
      autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout = 200})
    augroup end
  ]],
  false
)

vim.api.nvim_exec(
  [[
    augroup TRIMWHITESPACE
      autocmd!
      autocmd BufWritePre * %s/\s\+$//e
    augroup end
  ]],
  false
)

vim.api.nvim_exec(
  [[
    augroup neovim_terminal
      autocmd!
      autocmd TermOpen * startinsert
      autocmd TermOpen * :set nonumber norelativenumber
      autocmd TermOpen * :set nobuflisted
      autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
      autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif
    augroup end
  ]],
  false
)

vim.cmd [[
  augroup cursor_location
    autocmd!
    autocmd BufReadPost * silent! normal! g`"zv
  augroup end
]] --Return to last cursor location in a file

local disabled_built_ins = {
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
  'matchit',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

-- Prevents auto comment new line
vim.cmd 'au BufEnter * set fo-=c fo-=r fo-=o'
