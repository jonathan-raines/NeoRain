local vim = vim
local opt = vim.opt

--Enable break indent
opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.colorcolumn = "100"
-- Set completeopt to have a better completion experience
opt.completeopt = 'menuone,noselect'
--Incremental live completion (note: this is now a default on master)
opt.conceallevel = 0
opt.cursorline = true
opt.expandtab = true
opt.foldtext = 'CustomFold()'
opt.foldlevelstart = 5
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
--Do not save when switching buffers (note: this is now a default on master)
opt.hidden = true
--Set highlight on search
opt.hlsearch = true
--Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.inccommand = 'nosplit'
opt.mouse = 'a'
opt.number = true
opt.numberwidth = 4 -- default is 4
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 8
opt.shiftwidth = 2
opt.shortmess:append("c")
opt.showmode = true
opt.sidescrolloff = 8
--Decrease update time
opt.signcolumn = 'yes'
opt.smartcase = true
opt.smartindent = true
opt.spell = false
opt.spelllang = "en"
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 2
--Set colorscheme (order is important here)
opt.termguicolors = true
opt.timeoutlen = 100
opt.title = true
opt.undodir = vim.fn.stdpath('cache') .. '/undo'
opt.undofile = true
opt.updatetime = 250
opt.wrap = false
opt.writebackup = false
-- Folding
vim.cmd('set foldnestmax=6')
vim.cmd('set foldlevelstart=20')

