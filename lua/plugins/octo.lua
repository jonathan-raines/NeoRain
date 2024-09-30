return {
  'pwntester/octo.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'ibhagwan/fzf-lua',
  },
  opts = {
    enable_builtin = true,
    picker = 'fzf-lua',
    default_to_projects_v2 = true
  },
  keys = {
    { '<leader>o', vim.cmd.Octo, desc = "Octo" }
  },
  cmd = 'Octo'
}
