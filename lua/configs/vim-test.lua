local M = {}

function M.setup()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  local keymaps = {
    ['<leader>tf'] = '<cmd>TestFile<CR>',
    ['<leader>tl'] = '<cmd>TestLast<CR>',
    ['<leader>tn'] = '<cmd>TestNearest<CR>',
    ['<leader>ts'] = '<cmd>TestSuite<CR>',
    ['<leader>tv'] = '<cmd>TestVisit<CR>',
  }

  for key, cmd in pairs(keymaps) do
    keymap('n', key, cmd, opts)
  end

  local wk_ok, wk = pcall(require, 'which-key')
  if wk_ok then
    local mappings = {
      t = {
        name = 'Testing',
        f = { 'Run Test File' },
        l = { 'Run Last Test' },
        n = { 'Run Nearest Test' },
        s = { 'Run Test Suite' },
        v = { 'Visit Test File' },
      },
    }

    wk.register(mappings, { prefix = '<leader>' })
  end
end

function M.config()
  vim.api.nvim_exec(
    [[
    function! DockerTransform(cmd)
      return "docker-compose exec $(tmux display-message -p '#S') " .a:cmd
    endfunction
  ]] ,
    false
  )

  vim.cmd [[ let test#custom_transformations = {'docker': function('DockerTransform')}]]
  vim.cmd [[ let test#transformation = 'docker']]
  vim.cmd [[ let g:test#basic#start_normal = 1 " If using basic strategy ]]
end

return M
