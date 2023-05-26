return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { "<leader>'", "<cmd>lua require('fzf-lua').resume()<CR>",                    desc = 'Resume Last Picker' },
    { '<leader>f', "<cmd>lua require('fzf-lua').files()<CR>",                     desc = 'Find Files' },
    { '<leader>o', "<cmd>lua require('fzf-lua').oldfiles({cwd_only = true})<CR>", desc = 'Old Files' },
    { '<leader>b', "<cmd>lua require('fzf-lua').buffers()<CR>",                   desc = 'Buffers' },
    { '<leader>/', "<cmd>lua require('fzf-lua').live_grep_native()<CR>",          desc = 'Live Grep' },
    { '<leader>j', "<cmd>lua require('fzf-lua').jumps()<CR>",                     desc = 'Jumps' },
    { '<leader>t', "<cmd>lua require('fzf-lua').tabs()<CR>",                      desc = 'Tabs' },
    { '/',         "<cmd>lua require('fzf-lua').lgrep_curbuf()<CR>",              desc = "Search Buffer" }
  }
}
