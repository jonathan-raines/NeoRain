local options = {
  clipboard = 'unnamedplus', -- allows neovim to access the system clipboard
  colorcolumn = '+1',
  completeopt = { 'menu', 'menuone', 'noselect' }, -- mostly just for cmp
  cursorline = true, -- highlight the current line
  cursorlineopt = 'number',
  expandtab = true, -- convert tabs to spaces
  foldexpr = 'nvim_treesitter#foldexpr()',
  foldlevelstart = 99,
  foldmethod = 'expr',
  hlsearch = false, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  inccommand = 'split', -- preview incremental substitute
  mouse = 'a', -- allow the mouse to be used in neovim
  number = true,
  relativenumber = true,
  scrolloff = 8,
  shiftround = true, -- round indent
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  sidescrolloff = 8,
  signcolumn = 'yes', -- always show the sign column, otherwise it would shift the text each time
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  swapfile = false, -- creates a swapfile
  splitright = true, -- force all vertical splits to go to the right of current window
  tabstop = 2, -- insert 2 spaces for a tab
  termguicolors = true, -- set term gui colors (most terminals support this)
  textwidth = 100,
  timeoutlen = 100, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion (4000ms default)
  wildignore = '**/node_modules/*, **/.git/*',
  wildmode = 'longest:full,full',
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  wrap = false, -- display lines as one long line
}


vim.opt.shortmess:append 'cI'
vim.opt.path:append '**'
vim.o.laststatus = 3
vim.o.winbar = "%{%v:lua.require'statusline.modules'.FileInfo()%} %#Normal# %{%v:lua.require'nvim-navic'.get_location()%}"

for k, v in pairs(options) do
  vim.opt[k] = v
end

local disabled_built_ins = {
  'netrw',
  'netrwPlugin',
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
  vim.g['loaded_' .. plugin] = false
end
