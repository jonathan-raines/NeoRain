local options = {
  colorcolumn = '+1',
  expandtab = true,     -- convert tabs to spaces
  hlsearch = false,     -- highlight all matches on previous search pattern
  inccommand = 'split', -- preview incremental substitute
  ignorecase = true,
  laststatus = 3,
  number = true,
  relativenumber = true,
  shiftwidth = 2,       -- the number of spaces inserted for each indentation
  showmode = false,     -- we don't need to see things like -- INSERT -- anymore
  signcolumn = 'yes',   -- always show the sign column, otherwise it would shift the text each time
  softtabstop = -1,     -- negative uses shiftwidth value
  splitbelow = true,    -- force all horizontal splits to go below current window
  splitright = true,    -- force all vertical splits to go to the right of current window
  smartcase = true,
  swapfile = false,     -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  textwidth = 100,
  timeoutlen = 500,
  undodir = os.getenv 'HOME' .. '/.vim/undodir',
  undofile = true, -- enable persistent undo
  wrap = false,    -- display lines as one long line
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.path:append '**'
vim.opt.shortmess:append 'cI'
