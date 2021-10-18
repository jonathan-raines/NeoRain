local vim = vim
local opt = vim.opt

opt.background = 'dark'
opt.clipboard = 'unnamedplus'
opt.colorcolumn = '100' -- performance penalty when turned on
opt.completeopt = 'menuone,noselect'
opt.cursorline = true -- performance penalty when turned on
opt.errorbells = false
opt.expandtab = true
opt.foldtext = 'CustomFold()'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldlevelstart = 99
opt.foldnestmax = 6
opt.foldmethod = 'expr'
opt.guifont = 'FiraCode Nerd Font:h12'
opt.hidden = true
opt.hlsearch = false
opt.ignorecase = true
opt.inccommand = 'split' -- 'nosplit'
opt.lazyredraw = true
opt.mouse = 'a'
opt.number = false -- default is off
opt.path = '**'
opt.pumheight = 10
opt.pumblend = 17
opt.relativenumber = true
opt.scrolloff = 8
opt.shiftwidth = 2
opt.shortmess:append 'cI'
opt.sidescrolloff = 8
opt.signcolumn = 'yes'
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 100
opt.title = true
opt.undodir = vim.fn.stdpath 'cache' .. '/undo'
opt.undofile = true
opt.updatetime = 100
opt.wildignore = '**/node_modules/*, **/.git/*'
opt.wildmenu = true
opt.wildmode = 'longest,list,full'
opt.wildoptions = 'pum'
opt.wrap = false

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout = 50})
  augroup end ]],
  false
)

vim.api.nvim_exec(
  [[
  augroup TRIMWHITESPACE
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
  augroup end ]],
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
  augroup end]],
  false
)

vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1

vim.g.loaded_ruby_provider = 0
