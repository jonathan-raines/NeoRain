---@diagnostic disable: undefined-global
local vim = vim
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', 'Q', '<Nop>', opts)

--Remap space as leader key
map('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

map('n', '<leader><space>', '<c-^>', opts)

map('n', 'H', '^', opts)
map('n', 'L', '$', opts)

-- Write / Quit
map('n', '<leader>w', ':w<CR>', opts)

map('n', '<leader>q', ':q!<CR>', opts)
map('n', '<leader>Q', ':bufdo bd!<CR>', opts)

map('n', '<leader>c', ':bd!<CR>', opts)
map('n', '<leader>C', ':call DeleteHiddenBuffers()<CR>', opts)

-- Keeping it centered
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)
map('n', 'J', 'mzJ`z', opts)
map('n', '{', '{zz', opts)
map('n', '}', '}zz', opts)
map('n', '<C-o>', '<C-o>zz', opts)
map('n', '<C-i>', '<C-i>zz', opts)

-- Undo break points
map('i', ',', ',<c-g>u', opts)
map('i', '.', '.<c-g>u', opts)
map('i', '!', '!<c-g>u', opts)
map('i', '?', '?<c-g>u', opts)

-- Jumplist mutations
vim.cmd 'nnoremap <expr> j (v:count > 5 ? "m\'" . v:count : "") . "j"'
vim.cmd 'nnoremap <expr> k (v:count > 5 ? "m\'" . v:count : "") . "k"'

-- Quickfix Navigation
map('n', ']q', ':cnext<CR>', opts)
map('n', '[q', ':cprevious<CR>', opts)

-- Buffer Navigation
map('n', ']b', ':bn<CR>', opts)
map('n', '[b', ':bp<CR>', opts)
map('n', '<Tab>', ':bn<CR>', opts)
map('n', '<Backspace>', ':bp<CR>', opts)

-- Escape
map('i', 'jk', '<ESC>', opts)
map('v', 'jk', '<ESC>', opts)

-- Move Lines Around
map('n', '<A-j>', ':m .+1<CR>==', opts)
map('n', '<A-k>', ':m .-2<CR>==', opts)
map('v', '<A-j>', ":m '>+1<CR>gv-gv", opts)
map('v', '<A-k>', ":m '<-2<CR>gv-gv", opts)

-- Move Windows Around
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Resize windows
map('n', '<C-Up>', ':resize -5<CR>', opts)
map('n', '<C-Down>', ':resize +5<CR>', opts)
map('n', '<C-Left>', ':vertical resize -5<CR>', opts)
map('n', '<C-Right>', ':vertical resize +5<CR>', opts)

-- Indent
-- map('v', '<', '<gv', opts)
-- map('v', '>', '>gv', opts)
-- map('n', '<', '<<', opts)
-- map('n', '>', '>>', opts)

-- Quickfix
map('n', '<C-q>', ':call QuickFixToggle()<CR>', opts)

-- QuickFixToggle
vim.api.nvim_exec(
  [[
  function! QuickFixToggle()
      if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
      else
      cclose
      endif
  endfunction]],
  false
)

-- Delete Hidden Buffers
vim.api.nvim_exec(
  [[
  function! DeleteHiddenBuffers() " Vim with the 'hidden' option
		let tpbl=[]
		call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
		for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
			silent execute 'bwipeout!' buf
		endfor
	endfunction]],
  false
)

function _G_set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd 'autocmd! TermOpen term://* lua _G_set_terminal_keymaps()'
