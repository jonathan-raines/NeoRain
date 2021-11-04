vim.cmd [[ let g:db_ui_auto_execute_table_helpers = 1 ]]

vim.cmd [[
    let g:dbs = [
    \  { 'name': 'app_manager_develop', 'url': 'postgres://postgres:welcome@localhost:5433/app_manager_backend_development' },
    \  { 'name': 'app_manager_test', 'url': 'postgres://postgres:welcome@localhost:5433/app_manager_backend_test' },
    \  { 'name': 'auth_develop', 'url': 'postgres://postgres:welcome@localhost:5433/oauth_service_development' },
    \  { 'name': 'auth_test', 'url': 'postgres://postgres:welcome@localhost:5433/oauth_service_test' },
    \  { 'name': 'media_develop', 'url': 'postgres://postgres:welcome@localhost:5433/thrillshare_development' },
    \  { 'name': 'media_test', 'url': 'postgres://postgres:welcome@localhost:5433/thrillshare_test' }
    \ ]
  ]]

vim.api.nvim_set_keymap('n', 'gj', ':DBUI<CR>', { noremap = true, silent = true })
