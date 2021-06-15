vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-x>', ':BufferClose<CR>', { noremap = true, silent = true })

-- Goto buffer in position...
-- nnoremap <silent>    <A-1> :BufferGoto 1<CR>
-- nnoremap <silent>    <A-2> :BufferGoto 2<CR>
-- nnoremap <silent>    <A-3> :BufferGoto 3<CR>
-- nnoremap <silent>    <A-4> :BufferGoto 4<CR>
-- nnoremap <silent>    <A-5> :BufferGoto 5<CR>
-- nnoremap <silent>    <A-6> :BufferGoto 6<CR>
-- nnoremap <silent>    <A-7> :BufferGoto 7<CR>
-- nnoremap <silent>    <A-8> :BufferGoto 8<CR>
-- nnoremap <silent>    <A-9> :BufferLast<CR>


