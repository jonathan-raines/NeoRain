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
    { '<leader>Fa', "<cmd>FzfLua<CR>",                                             desc = 'Pickers' },
    { '<leader>Ff', "<cmd>FzfLua files<CR>",                                       desc = 'Find Files' },
    { '<leader>Fg', "<cmd>FzfLua grep<CR>",                                        desc = 'Grep' },
    { '<leader>FG', "<cmd>FzfLua grep_project<CR>",                                desc = 'Grep Project' },
    { '<leader>Fh', "<cmd>FzfLua git_status<CR>",                                  desc = 'Changed Git Files' },
    { '<leader>Fk', "<cmd>FzfLua keymaps<CR>",                                     desc = 'Keymaps' },
    { '<leader>Fm', "<cmd>FzfLua marks<CR>",                                       desc = 'Marks' },
    { '<leader>Fs', "<cmd>FzfLua grep_cword<CR>",                                  desc = 'Word Under Cursor' },
    { '<leader>Fo', "<cmd>lua require('fzf-lua').oldfiles({cwd_only = true})<CR>", desc = 'Old Files' },
    { '<leader>Fc', "<cmd>FzfLua colorschemes<CR>",                                desc = 'Colorscheme' },
    { '<leader>Fj', "<cmd>FzfLua jumps<CR>",                                       desc = 'Jumps' },
    { '<leader>Fq', "<cmd>FzfLua quickfix<CR>",                                    desc = 'Quickfix' },
    { '<leader>Fl', "<cmd>FzfLua loclist<CR>",                                     desc = 'Local List' },
    { "<leader>'",  "<cmd>FzfLua resume<CR>",                                      desc = 'Resume Last Picker' },
    { '<leader>b',  "<cmd>FzfLua buffers<CR>",                                     desc = 'Buffers' },
    { '<leader>v',  "<cmd>FzfLua tabs<CR>",                                        desc = 'Tabs' },
    { '<leader>/',  "<cmd>FzfLua live_grep_native<CR>",                            desc = 'Live Grep' },
    { '/',          "<cmd>FzfLua lgrep_curbuf<CR>",                                desc = "Search Buffer" }
  }
}
