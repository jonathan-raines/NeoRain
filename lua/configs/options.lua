local options = {
	colorcolumn    = '+1',
	completeopt    = 'menuone,noinsert,noselect', -- Customize completions
	expandtab      = true,                 -- convert tabs to spaces
	foldlevel      = 99,                   -- Display all folds except top ones
	foldmethod     = 'expr',
	foldexpr       = 'v:lua.vim.treesitter.foldexpr()',
	foldtext       = 'v:lua.vim.treesitter.foldtext()',
	formatoptions  = 'rqnl1j', -- Improve comment editing
	hlsearch       = false, -- highlight all matches on previous search pattern
	inccommand     = 'split', -- preview incremental substitute
	incsearch      = true, -- Show search results while typing
	infercase      = true, -- Infer letter cases for a richer built-in keyword completion
	ignorecase     = true, -- Ignore case when searching (use `\C` to force not doing that)
	laststatus     = 3, -- Global Statusline
	list           = true,
	listchars      = {
		extends = '.',
		precedes = '|',
		tab = "⇥ ",
		leadmultispace = "│ ",
		trail = "␣",
		nbsp = "⍽"
	},
	number         = true,
	relativenumber = true,
	shiftwidth     = 2, -- the number of spaces inserted for each indentation
	showmode       = false, -- we don't need to see things like -- INSERT -- anymore
	signcolumn     = 'yes', -- always show the sign column, otherwise it would shift the text each time
	softtabstop    = -1, -- negative uses shiftwidth value
	splitbelow     = true, -- force all horizontal splits to go below current window
	splitright     = true, -- force all vertical splits to go to the right of current window
	smartcase      = true,
	smartindent    = true, -- Make indenting smart
	swapfile       = false, -- creates a swapfile
	tabstop        = 2, -- Insert 2 spaces for a tab
	termguicolors  = true, -- set term gui colors (most terminals support this)
	textwidth      = 100,
	timeoutlen     = 500,
	undodir        = os.getenv 'HOME' .. '/.vim/undodir',
	undofile       = true, -- enable persistent undo
	wrap           = false, -- display lines as one long line
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.shortmess:append 'cI'
-- vim.opt.iskeyword:append('-') -- Treat dash separated words as a word text object
