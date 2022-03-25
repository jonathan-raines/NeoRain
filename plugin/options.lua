local options = {
  backup = false, -- creates a backup file
  clipboard = 'unnamedplus', -- allows neovim to access the system clipboard
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
  scrolloff = 3,
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
  timeoutlen = 100, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion (4000ms default)
  wildignore = '**/node_modules/*, **/.git/*',
  wildmode = 'longest:full,full',
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  wrap = false, -- display lines as one long line
}

vim.opt.shortmess:append 'cI'
-- vim.opt.path:append '**'

vim.cmd [[set path+=**]]

for k, v in pairs(options) do
  vim.opt[k] = v
end

local disabled_built_ins = {
  'netrw',
  'netrwPlugin',
  'netrwSettings',
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
  'matchit',
  'matchparen',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
}

for _, plugin in ipairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

vim.g.do_filetype_lua = 1
vim.g.did_load_filetype = 0
