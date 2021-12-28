local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal Mode --
keymap('n', '<leader><space>', '<c-^>', opts)

-- Write / Quit
keymap('n', '<leader>w', ':w<CR>', opts)
keymap('n', '<leader>q', ':q!<CR>', opts)

keymap('n', '<leader>c', ':bd!<CR>', opts)
keymap('n', '<leader>C', ':call DeleteHiddenBuffers()<CR>', opts)

-- Keeping it centered
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)
keymap('n', 'J', 'mzJ`z', opts)
keymap('n', '{', '{zz', opts)
keymap('n', '}', '}zz', opts)
keymap('n', '<C-o>', '<C-o>zz', opts)
keymap('n', '<C-i>', '<C-i>zz', opts)

-- Quickfix Navigation
keymap('n', ']q', ':cnext<CR>', opts)
keymap('n', '[q', ':cprevious<CR>', opts)

-- Buffer Navigation
keymap('n', ']b', ':bn<CR>', opts)
keymap('n', '[b', ':bp<CR>', opts)
keymap('n', ']B', ':blast<CR>', opts)
keymap('n', '[B', ':bfirst<CR>', opts)

-- Move Lines Around
keymap('n', '<A-j>', ':m .+1<CR>==', opts)
keymap('n', '<A-k>', ':m .-2<CR>==', opts)

-- Indent
keymap('n', '<', '<<', opts)
keymap('n', '>', '>>', opts)

-- Quickfix
keymap('n', '<C-q>', ':call QuickFixToggle()<CR>', opts)

-- Move Windows Around
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize windows
keymap('n', '<C-Up>', ':resize -5<CR>', opts)
keymap('n', '<C-Down>', ':resize +5<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -5<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +5<CR>', opts)

-- Insert Mode --

-- Save
keymap('i', '<C-s>', '<ESC>:w<CR>', opts)

-- Undo break points
keymap('i', ',', ',<c-g>u', opts)
keymap('i', '.', '.<c-g>u', opts)
keymap('i', '!', '!<c-g>u', opts)
keymap('i', '?', '?<c-g>u', opts)

-- Escape
keymap('i', 'jk', '<ESC>', opts)

-- Visual Mode --
keymap('v', 'jk', '<ESC>', opts)

-- Move Lines Around
keymap('v', '<A-j>', ":m '>+1<CR>gv-gv", opts)
keymap('v', '<A-k>', ":m '<-2<CR>gv-gv", opts)

-- Indent
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Jumplist mutations
vim.cmd 'nnoremap <expr> j (v:count > 5 ? "m\'" . v:count : "") . "j"'
vim.cmd 'nnoremap <expr> k (v:count > 5 ? "m\'" . v:count : "") . "k"'

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

-- Terminal Mode --
keymap('t', 'jk', '<C-\\><C-n>', term_opts)
keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

-- Spotify
vim.api.nvim_set_keymap('n', '<leader>sn', '<Plug>(SpotifySkip)', { silent = true }) -- Skip the current track
vim.api.nvim_set_keymap('n', '<leader>sp', '<Plug>(SpotifyPause)', { silent = true }) -- Pause/Resume the current track
vim.api.nvim_set_keymap('n', '<leader>ss', '<Plug>(SpotifySave)', { silent = true }) -- Add the current track to your library
vim.api.nvim_set_keymap('n', '<leader>so', ':Spotify<CR>', { silent = true }) -- Open Spotify Search window
vim.api.nvim_set_keymap('n', '<leader>sd', ':SpotifyDevices<CR>', { silent = true }) -- Open Spotify Devices window

-- Trouble
vim.api.nvim_set_keymap('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>xd', '<cmd>Trouble document_diagnostics<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>xl', '<cmd>Trouble loclist<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>xq', '<cmd>Trouble quickfix<cr>', { silent = true, noremap = true })
