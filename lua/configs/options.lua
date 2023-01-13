local options = {
  colorcolumn = '+1',
  expandtab = true, -- convert tabs to spaces
  foldlevelstart = 99,
  hlsearch = false, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  inccommand = 'split', -- preview incremental substitute
  laststatus = 3,
  mouse = 'a', -- allow the mouse to be used in neovim
  number = true,
  relativenumber = true,
  scrolloff = 999,
  shiftround = true, -- round indent
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  sidescrolloff = 8,
  signcolumn = 'yes', -- always show the sign column, otherwise it would shift the text each time
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  softtabstop = -1, -- negative uses shiftwidth value
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  tabstop = 2, -- insert 2 spaces for a tab
  termguicolors = true, -- set term gui colors (most terminals support this)
  textwidth = 100,
  timeoutlen = 500,
  undodir = os.getenv 'HOME' .. '/.vim/undodir',
  undofile = true, -- enable persistent undo
  -- winbar = "%{%v:lua.require'configs.statusline.modules'.FileInfo()%} %#Normal# %{%v:lua.require'nvim-navic'.get_location()%} %= %{%v:lua.vim.api.nvim_win_get_number(0)%}",
  winbar = "%{%v:lua.require'configs.statusline.modules'.FileInfo()%} %#Normal# %= %{%v:lua.vim.api.nvim_win_get_number(0)%}",
  wrap = false, -- display lines as one long line
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.fo:remove { 'c', 'r', 'o' } -- 'No commenting new line'
vim.opt.path:append '**'
vim.opt.shortmess:append 'cI'
