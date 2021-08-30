local vim = vim
local opt = vim.opt

--Enable break indent
opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.colorcolumn = "100"
opt.completeopt = 'menuone,noselect'
opt.conceallevel = 0
opt.cursorline = true
opt.errorbells = false
opt.expandtab = true
opt.foldtext = 'CustomFold()'
opt.foldlevelstart = 5
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.guifont = 'FiraCode Nerd Font:h12'
opt.hidden = true
opt.hlsearch = true
opt.ignorecase = true
opt.inccommand = 'nosplit'
opt.list = true
opt.listchars = 'trail:-'
opt.mouse = 'a'
opt.number = true
opt.numberwidth = 4 -- default is 4
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 8
opt.shiftwidth = 2
opt.shortmess:append("cI")
opt.showmode = true
opt.sidescrolloff = 8
opt.signcolumn = 'yes'
opt.smartcase = true
opt.smartindent = true
opt.spell = false
opt.spelllang = "en"
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 100
opt.title = true
opt.undodir = vim.fn.stdpath('cache') .. '/undo'
opt.undofile = true
opt.updatetime = 100
opt.wrap = false
opt.writebackup = false

-- Folding
vim.cmd('set foldnestmax=6')
vim.cmd('set foldlevelstart=20')

vim.cmd [[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]]
vim.cmd [[ autocmd BufWinEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o ]]
vim.cmd [[ autocmd BufRead * setlocal formatoptions-=c formatoptions-=r formatoptions-=o ]]
vim.cmd [[ autocmd BufNewFile * setlocal formatoptions-=c formatoptions-=r formatoptions-=o ]]
vim.cmd [[ autocmd BufWinEnter NvimTree set colorcolumn=0 nocursorcolumn ]]

-- Highlight on yank
vim.api.nvim_exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end ]], false)

-- Disable various builtin plugins in Vim that bog down speed
vim.g.loaded_matchparen        = 1
vim.g.loaded_matchit           = 1
vim.g.loaded_logiPat           = 1
vim.g.loaded_rrhelper          = 1
vim.g.loaded_tarPlugin         = 1
vim.g.loaded_gzip              = 1
vim.g.loaded_zipPlugin         = 1
vim.g.loaded_2html_plugin      = 1
vim.g.loaded_shada_plugin      = 1
vim.g.loaded_spellfile_plugin  = 1
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins    = 1
