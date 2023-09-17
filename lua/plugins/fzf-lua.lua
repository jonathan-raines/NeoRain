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
    { '<leader>fa', "<cmd>FzfLua<CR>",                        desc = 'Pickers' },
    { '<leader>ff', "<cmd>FzfLua files<CR>",                  desc = 'Find Files' },
    { '<leader>fg', "<cmd>FzfLua grep<CR>",                   desc = 'Grep' },
    { '<leader>fG', "<cmd>FzfLua grep_project<CR>",           desc = 'Grep Project' },
    { '<leader>fh', "<cmd>FzfLua git_status<CR>",             desc = 'Changed Git Files' },
    { '<leader>fj', "<cmd>FzfLua jumps<CR>",                  desc = 'Jumps' },
    { '<leader>fk', "<cmd>FzfLua keymaps<CR>",                desc = 'Keymaps' },
    { '<leader>fl', "<cmd>FzfLua loclist<CR>",                desc = 'Local List' },
    { '<leader>fm', "<cmd>FzfLua marks<CR>",                  desc = 'Marks' },
    { '<leader>fo', "<cmd>FzfLua oldfiles cwd_only=true<CR>", desc = 'Old Files' },
    { '<leader>fq', "<cmd>FzfLua quickfix<CR>",               desc = 'Quickfix' },
    { '<leader>fs', "<cmd>FzfLua grep_cword<CR>",             desc = 'Word Under Cursor' },
    { '<leader>b',  "<cmd>FzfLua buffers<CR>",                desc = 'Buffers' },
    { '<leader>v',  "<cmd>FzfLua tabs<CR>",                   desc = 'Tabs' },
    { "<leader>'",  "<cmd>FzfLua resume<CR>",                 desc = 'Resume Last Picker' },
    { '<leader>/',  "<cmd>FzfLua live_grep_native<CR>",       desc = 'Live Grep' },
    { '<leader>:',  "<cmd>FzfLua command_history<CR>",        desc = 'Command History' },
    { '/',          "<cmd>FzfLua lgrep_curbuf<CR>",           desc = "Search Buffer" }
  }
}
