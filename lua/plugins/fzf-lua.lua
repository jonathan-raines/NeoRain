return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require 'fzf-lua'.setup {
      -- 'telescope',
      -- 'fzf-tmux',
      keymap = {
        builtin = {
          ['<C-d>'] = 'preview-page-down',
          ['<C-u>'] = 'preview-page-up',
        },
        fzf = {
          ["ctrl-q"] = "select-all+accept"
        }
      },
      -- winopts = {
      --   height = 0.7,
      --   width = 0.55,
      --   preview = {
      --     scrollbar = false,
      --     layout = 'vertical',
      --     vertical = 'up:40%',
      --   },
      -- },
      buffers = {
        winopts = {
          height = 0.4,
          width = 0.4,
          preview = {
            scrollbar = false,
            layout = 'vertical',
            vertical = 'up:40%',
            hidden = 'hidden'
          },
        }
      }
    }
  end,
  keys = {
    { '<leader>fa', "<cmd>FzfLua<CR>",                        desc = 'Pickers' },
    { '<leader>fb', "<cmd>FzfLua buffers<CR>",                desc = 'Buffers' },
    { '<leader>ff', "<cmd>FzfLua files<CR>",                  desc = 'Find Files' },
    { '<leader>fh', "<cmd>FzfLua git_status<CR>",             desc = 'Changed Git Files' },
    { '<leader>fl', "<cmd>FzfLua loclist<CR>",                desc = 'Local List' },
    { '<leader>fm', "<cmd>FzfLua marks<CR>",                  desc = 'Marks' },
    { '<leader>fo', "<cmd>FzfLua oldfiles cwd_only=true<CR>", desc = 'Old Files' },
    { '<leader>fq', "<cmd>FzfLua quickfix<CR>",               desc = 'Quickfix' },
    { "<leader>fr", "<cmd>FzfLua registers<CR>",              desc = 'Registers' },
    { '<leader>fs', "<cmd>FzfLua grep<CR>",                   desc = 'String' },
    { '<leader>ft', "<cmd>FzfLua tabs<CR>",                   desc = 'Tabs' },
    { '<leader>fw', "<cmd>FzfLua grep_cword<CR>",             desc = 'Word' },
    { '<leader>f/', "<cmd>FzfLua lgrep_curbuf<CR>",           desc = "Search Buffer" },
    { '<leader>/',  "<cmd>FzfLua live_grep_native<CR>",       desc = 'Live Grep' },
  }
}
