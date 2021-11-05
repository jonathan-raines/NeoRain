local vim = vim
local map = vim.api.nvim_set_keymap

--Remap space as leader key
map('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Explorer
map('n', '<leader><space>', '<C-^>', { noremap = true, silent = true })

-- Write / Quit
map('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })
map('n', '<leader>q', ':q!<CR>', { noremap = true, silent = true })

-- Keeping it centered
map('n', 'n', 'nzzzv', { silent = true, noremap = true })
map('n', 'N', 'Nzzzv', { silent = true, noremap = true })
map('n', 'J', 'mzJ`z', { silent = true, noremap = true })
map('n', '{', '{zz', { silent = true, noremap = true })
map('n', '}', '}zz', { silent = true, noremap = true })
map('n', '<C-o>', '<C-o>zz', { silent = true, noremap = true })
map('n', '<C-i>', '<C-i>zz', { silent = true, noremap = true })

-- Undo break points
map('i', ',', ',<c-g>u', { silent = true, noremap = true })
map('i', '.', '.<c-g>u', { silent = true, noremap = true })
map('i', '!', '!<c-g>u', { silent = true, noremap = true })
map('i', '?', '?<c-g>u', { silent = true, noremap = true })

-- Jumplist mutations
vim.cmd 'nnoremap <expr> j (v:count > 5 ? "m\'" . v:count : "") . "j"'
vim.cmd 'nnoremap <expr> k (v:count > 5 ? "m\'" . v:count : "") . "k"'

-- Quickfix Navigation
map('n', ']q', ':cnext<CR>', { silent = true, noremap = true })
map('n', '[q', ':cprevious<CR>', { silent = true, noremap = true })
map('n', ']Q', ':clast<CR>', { silent = true, noremap = true })
map('n', '[Q', ':cfirst<CR>', { silent = true, noremap = true })

-- Buffer Navigation
map('n', ']b', ':bn<CR>', { silent = true, noremap = true })
map('n', '[b', ':bp<CR>', { silent = true, noremap = true })
map('n', ']B', ':blast<CR>', { silent = true, noremap = true })
map('n', '[B', ':bfirst<CR>', { silent = true, noremap = true })

-- Escape
map('i', 'jk', '<ESC>', { silent = true, noremap = true })
map('v', 'jk', '<ESC>', { silent = true, noremap = true })

-- Move Lines Around
map('n', '<A-j>', ':m .+1<CR>==', { silent = true, noremap = true })
map('n', '<A-k>', ':m .-2<CR>==', { silent = true, noremap = true })
map('v', '<A-j>', ":m '>+1<CR>gv-gv", { silent = true, noremap = true })
map('v', '<A-k>', ":m '<-2<CR>gv-gv", { silent = true, noremap = true })

-- Move Windows Around
map('n', '<C-h>', '<C-w>h', { silent = true, noremap = true })
map('n', '<C-j>', '<C-w>j', { silent = true, noremap = true })
map('n', '<C-k>', '<C-w>k', { silent = true, noremap = true })
map('n', '<C-l>', '<C-w>l', { silent = true, noremap = true })

-- Resize windows
map('n', '<C-Up>', ':resize -5<CR>', { silent = true, noremap = true })
map('n', '<C-Down>', ':resize +5<CR>', { silent = true, noremap = true })
map('n', '<C-Left>', ':vertical resize -5<CR>', { silent = true, noremap = true })
map('n', '<C-Right>', ':vertical resize +5<CR>', { silent = true, noremap = true })

-- Indent
map('v', '<', '<gv', { silent = true, noremap = true })
map('v', '>', '>gv', { silent = true, noremap = true })
map('n', '<', '<<', { silent = true, noremap = true })
map('n', '>', '>>', { silent = true, noremap = true })

-- Quickfix
map('n', '<C-q>', ':call QuickFixToggle()<CR>', { silent = true, noremap = true })

-- Increment / Decrement
map('v', '<C-a>', '<C-a>gv-gv', { silent = true, noremap = true })
map('v', '<C-x>', '<C-x>gv-gv', { silent = true, noremap = true })

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

-- Custom Fold
vim.api.nvim_exec(
  [[function! CustomFold()
      return printf('   %-6d%s', v:foldend - v:foldstart + 1, getline(v:foldstart))
  endfunction]],
  false
)

-- Delete Hidden Buffers
vim.api.nvim_exec(
  [[function DeleteHiddenBuffers() " Vim with the 'hidden' option
		let tpbl=[]
		call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
		for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
			silent execute 'bwipeout!' buf
		endfor
	endfunction]],
  false
)
