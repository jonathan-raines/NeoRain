-- Set leader
if O.leader_key == ' ' or O.leader_key == 'space' then
    vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
    vim.g.mapleader = ' '
else
    vim.api.nvim_set_keymap('n', O.leader_key, '<NOP>', {noremap = true, silent = true})
    vim.g.mapleader = O.leader_key
end

-- Folding
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.cmd('set foldnestmax=4')
vim.cmd('set foldlevelstart=20')

-- Lines
vim.wo.number = true -- set numbered lines
vim.wo.relativenumber = true -- set relative number
vim.wo.cursorline = true -- Enable highlighting of the current line
vim.wo.signcolumn = "yes" -- Always show the sign column, otherwise it would shift the text each time
vim.wo.colorcolumn = "90"

-- Line Wrap
vim.wo.wrap = false -- Line wrap
vim.cmd('set whichwrap+=<,>,[,],h,l') -- move to next line with theses keys

-- Misc
vim.o.mouse = "a" -- Enable your mouse
vim.o.termguicolors = true -- set term gui colors most terminals support this
vim.o.fileencoding = "utf-8" -- The encoding written to file
vim.o.updatetime = 300 -- Faster completion
vim.o.timeoutlen = 100
vim.wo.scrolloff = 5

-- Settings
vim.o.hidden = true
vim.cmd('set iskeyword+=-') -- treat dash separated words as a word text object"
vim.cmd('set shortmess+=c') -- Don't pass messages to |ins-completion-menu|.
vim.cmd('set inccommand=split') -- Make substitution work in realtime
vim.o.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.o.guifont = "FiraCode Nerd Font:h17"
vim.cmd('filetype plugin on') -- filetype detection

-- Splits
vim.o.splitbelow = true -- Horizontal splits will automatically be below
vim.o.splitright = true -- Vertical splits will automatically be to the right

-- Tabs
vim.cmd('set expandtab') -- Converts tabs to spaces
vim.cmd('set ts=4') -- Insert 2 spaces for a tab
vim.cmd('set sw=4') -- Change the number of space characters inserted for indentation
vim.bo.smartindent = true -- Makes indenting smart
vim.o.showtabline = 2 -- Always show tabs

-- UI
vim.cmd('syntax on') -- syntax highlighting
vim.o.pumheight = 10 -- Makes popup menu smaller
vim.o.cmdheight = 2 -- More space for displaying messages
vim.g.nvim_tree_disable_netrw = false -- enable netrw for remote gx gf support (must be set before plugin's packadd)
vim.g.loaded_netrwPlugin = true -- needed for netrw gx command to open remote links in browser

--Window
vim.o.title = true -- Set the window's title, reflecting the filel current being worked on
vim.o.titlestring="%<%F%=%l/%L - nvim"

