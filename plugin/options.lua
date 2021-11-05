local opt = vim.opt

opt.clipboard = 'unnamedplus'
opt.colorcolumn = '100' -- performance penalty when turned on
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.cursorline = true -- performance penalty when turned on
opt.expandtab = true
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldmethod = 'expr'
opt.ignorecase = true
opt.inccommand = 'split' -- 'nosplit'
opt.mouse = 'a'
opt.number = true
opt.relativenumber = true
opt.scrolloff = 8
opt.shiftwidth = 2
opt.shortmess:append 'cI'
opt.sidescrolloff = 8
opt.signcolumn = 'yes'
opt.smartcase = true
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 100
opt.title = true
opt.undodir = vim.fn.stdpath 'cache' .. '/undo'
opt.undofile = true
opt.wildmenu = true
opt.wildmode = 'longest:full,full'
opt.wildignore = '**/node_modules/*, **/.git/*'
opt.wrap = false

-- Highlight on yank
vim.api.nvim_exec(
  [[
    augroup YankHighlight
      autocmd!
      autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout = 50})
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
