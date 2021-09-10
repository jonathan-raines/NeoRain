local vim = vim

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keeping it centered
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', 'J', 'mzJ`z', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '{', '{zz', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '}', '}zz', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<C-o>', '<C-o>zz', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<C-i>', '<C-i>zz', { silent = true, noremap = true })

-- Undo break points
vim.api.nvim_set_keymap('i', ',', ',<c-g>u', { silent = true, noremap = true })
vim.api.nvim_set_keymap('i', '.', '.<c-g>u', { silent = true, noremap = true })
vim.api.nvim_set_keymap('i', '!', '!<c-g>u', { silent = true, noremap = true })
vim.api.nvim_set_keymap('i', '?', '?<c-g>u', { silent = true, noremap = true })

-- Jumplist mutations
vim.cmd 'nnoremap <expr> j (v:count > 5 ? "m\'" . v:count : "") . "j"'
vim.cmd 'nnoremap <expr> k (v:count > 5 ? "m\'" . v:count : "") . "k"'

-- Escape
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', 'jk', ':noh<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('v', 'jk', '<ESC>', { silent = true, noremap = true })

-- Move Lines Around
vim.api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<A-k>', ':m .-2<CR>==', { silent = true, noremap = true })
vim.api.nvim_set_keymap('i', '<A-j>', '<ESC>:m .+1<CR>==gi', { silent = true, noremap = true })
vim.api.nvim_set_keymap('i', '<A-k>', '<ESC>:m .-2<CR>==gi', { silent = true, noremap = true })
vim.api.nvim_set_keymap('v', '<A-j>', ":move '>+1<CR>gv-gv", { silent = true, noremap = true })
vim.api.nvim_set_keymap('v', '<A-k>', ":move '<-2<CR>gv-gv", { silent = true, noremap = true })

-- Redo
vim.api.nvim_set_keymap('n', 'U', '<C-R>', { silent = true, noremap = true })

-- Move Windows Around
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { silent = true, noremap = true })

-- Jump to start/end of line
vim.api.nvim_set_keymap('n', 'H', '^', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', 'L', '$', { silent = true, noremap = true })

-- Resize windows
vim.api.nvim_set_keymap('n', '<C-Up>', ':resize -5<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<C-Down>', ':resize +5<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<C-Left>', ':vertical resize -5<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +5<CR>', { silent = true, noremap = true })

-- Indent
vim.api.nvim_set_keymap('v', '<', '<gv', { silent = true, noremap = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<', '<<', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '>', '>>', { silent = true, noremap = true })

-- Quickfix
vim.api.nvim_set_keymap('n', '<C-q>', ':call QuickFixToggle()<CR>', { silent = true, noremap = true })

-- Y behaves like C/D
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- Increment / Decrement
vim.api.nvim_set_keymap('n', '+', '<C-a>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '-', '<C-x>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('v', '+', '<C-a>gv-gv', { silent = true, noremap = true })
vim.api.nvim_set_keymap('v', '-', '<C-x>gv-gv', { silent = true, noremap = true })

vim.api.nvim_set_keymap('n', '<Backspace>', '<C-^>', { silent = true, noremap = true })

-- QuickFixToggle
vim.cmd [[function! QuickFixToggle()
      if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
      else
      cclose
      endif
  endfunction]]

-- Custom Fold
vim.cmd [[function! CustomFold()
      return printf('   %-6d%s', v:foldend - v:foldstart + 1, getline(v:foldstart))
  endfunction]]

vim.cmd [[function DeleteHiddenBuffers() " Vim with the 'hidden' option
		let tpbl=[]
		call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
		for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
			silent execute 'bwipeout' buf
		endfor
	endfunction]]

vim.api.nvim_set_keymap('n', '<leader>C', ':call DeleteHiddenBuffers()<CR>', { silent = true, noremap = true })
