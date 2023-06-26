return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>ff', "<cmd>FzfLua files<CR>",                                       desc = 'Find Files' },
    { '<leader>fh', "<cmd>FzfLua git_status<CR>",                                  desc = 'Changed Git Files' },
    { '<leader>fs', "<cmd>FzfLua grep_cword<CR>",                                  desc = 'Word Under Cursor' },
    { '<leader>fo', "<cmd>lua require('fzf-lua').oldfiles({cwd_only = true})<CR>", desc = 'Old Files' },
    { '<leader>fj', "<cmd>FzfLua jumps<CR>",                                       desc = 'Jumps' },
    { '<leader>b',  "<cmd>FzfLua buffers<CR>",                                     desc = 'Buffers' },
    { '<leader>t',  "<cmd>FzfLua tabs<CR>",                                        desc = 'Tabs' },
    { "<leader>'",  "<cmd>FzfLua resume<CR>",                                      desc = 'Resume Last Picker' },
    { '<leader>/',  "<cmd>FzfLua live_grep_native<CR>",                            desc = 'Live Grep' },
    { '/',          "<cmd>FzfLua lgrep_curbuf<CR>",                                desc = "Search Buffer" }
  }
}
