return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require 'fzf-lua'.setup {
      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept"
        }
      }
    }
  end,
  keys = {
    { '<leader>ff', "<cmd>FzfLua files<CR>",                                       desc = 'Find Files' },
    { '<leader>fh', "<cmd>FzfLua git_status<CR>",                                  desc = 'Changed Git Files' },
    { '<leader>fk', "<cmd>FzfLua keymaps<CR>",                                     desc = 'Keymaps' },
    { '<leader>fk', "<cmd>FzfLua marks<CR>",                                       desc = 'Marks' },
    { '<leader>fs', "<cmd>FzfLua grep_cword<CR>",                                  desc = 'Word Under Cursor' },
    { '<leader>fo', "<cmd>lua require('fzf-lua').oldfiles({cwd_only = true})<CR>", desc = 'Old Files' },
    { '<leader>fc', "<cmd>FzfLua colorschemes<CR>",                                desc = 'Colorscheme' },
    { '<leader>fj', "<cmd>FzfLua jumps<CR>",                                       desc = 'Jumps' },
    { '<leader>fq', "<cmd>FzfLua quickfix<CR>",                                    desc = 'Quickfix' },
    { '<leader>fl', "<cmd>FzfLua loclist<CR>",                                     desc = 'Local List' },
    { "<leader>'",  "<cmd>FzfLua resume<CR>",                                      desc = 'Resume Last Picker' },
    { '<leader>b',  "<cmd>FzfLua buffers<CR>",                                     desc = 'Buffers' },
    { '<leader>v',  "<cmd>FzfLua tabs<CR>",                                        desc = 'Tabs' },
    { '<leader>/',  "<cmd>FzfLua live_grep_native<CR>",                            desc = 'Live Grep' },
    { '/',          "<cmd>FzfLua lgrep_curbuf<CR>",                                desc = "Search Buffer" }
  }
}
