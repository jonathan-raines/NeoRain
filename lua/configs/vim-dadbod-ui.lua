vim.cmd [[ let g:db_ui_auto_execute_table_helpers = 1 ]]

vim.cmd [[
    let g:dbs = [
    \  { 'name': 'app_manager_develop', 'url': 'postgres://postgres:welcome@localhost:5433/appbuild_portal_development' },
    \  { 'name': 'app_manager_test', 'url': 'postgres://postgres:welcome@localhost:5433/appbuild_portal_test' },
    \  { 'name': 'auth_develop', 'url': 'postgres://postgres:welcome@localhost:5433/oauth_service_development' },
    \  { 'name': 'auth_test', 'url': 'postgres://postgres:welcome@localhost:5433/oauth_service_test' },
    \  { 'name': 'engage_develop', 'url': 'postgres://postgres:welcome@localhost:5433/engage_development' },
    \  { 'name': 'engage_test', 'url': 'postgres://postgres:welcome@localhost:5433/engage_test' },
    \  { 'name': 'files_develop', 'url': 'postgres://postgres:welcome@localhost:5433/files_development' },
    \  { 'name': 'files_test', 'url': 'postgres://postgres:welcome@localhost:5433/files_test' },
    \  { 'name': 'media_develop', 'url': 'postgres://postgres:welcome@localhost:5433/thrillshare_development' },
    \  { 'name': 'media_test', 'url': 'postgres://postgres:welcome@localhost:5433/thrillshare_test' }
    \ ]
  ]]

vim.api.nvim_create_augroup('DadBodUI', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Highlight text when yanking',
  group = 'DadBodUI',
  pattern = 'dbout',
  callback = function()
    vim.cmd [[ set colorcolumn="" ]]
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Setup Dadbod completion plugin',
  group = 'DadBodUI',
  pattern = 'sql,mysql,plsql',
  callback = function()
    require 'cmp'.setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
  end,
})
