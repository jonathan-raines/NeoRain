local options = {
  clipboard = 'unnamedplus', -- allows neovim to access the system clipboard
  colorcolumn = '+1',
  completeopt = { 'menu', 'menuone', 'noselect' }, -- mostly just for cmp
  expandtab = true, -- convert tabs to spaces
  foldlevelstart = 99,
  hlsearch = false, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  inccommand = 'split', -- preview incremental substitute
  laststatus = 3,
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
  splitkeep = 'screen',
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
  winbar = "%{%v:lua.require'statusline.modules'.FileInfo()%} %#Normal# %{%v:lua.require'nvim-navic'.get_location()%}",
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  wrap = false, -- display lines as one long line
}

vim.opt.shortmess:append 'cI'
vim.opt.path:append '**'

for k, v in pairs(options) do
  vim.opt[k] = v
end

---WORKAROUND
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
  callback = function()
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
  end
})
---ENDWORKAROUND
