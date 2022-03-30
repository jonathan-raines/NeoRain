vim.api.nvim_exec(
  [[
    function! DockerTransform(cmd)
      return "docker-compose exec $(tmux display-message -p '#S') " .a:cmd
    endfunction
  ]],
  false
)

vim.cmd [[ let test#custom_transformations = {'docker': function('DockerTransform')}]]
vim.cmd [[ let test#transformation = 'docker']]
vim.cmd [[ let g:test#basic#start_normal = 1 " If using basic strategy ]]
