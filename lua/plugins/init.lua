return {
  'nvim-tree/nvim-web-devicons',

  { "b0o/schemastore.nvim", lazy = true },

  {
    'MeanderingProgrammer/markdown.nvim',
    name = 'render-markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('render-markdown').setup({})
    end,
    ft = { 'markdown' }
  },

  {
    'echasnovski/mini.pick',
    dependencies = 'echasnovski/mini.extra',
    config = function()
      require 'mini.pick'.setup {}
      require 'mini.extra'.setup {}

      vim.api.nvim_create_autocmd("User", {
        desc = 'Set transparent MiniFiles background',
        group = vim.api.nvim_create_augroup('MiniFiles', { clear = true }),
        pattern = 'MiniPickStart',
        callback = function()
          vim.api.nvim_set_hl(0, 'MiniPickNormal', { bg = 'none' })
          vim.api.nvim_set_hl(0, 'MiniPickBorder', { bg = 'none' })
        end
      })
    end,
    keys = {
      { '<leader>sb', function() vim.cmd.Pick 'buffers' end,   desc = '[MiniPick] Buffers' },
      { '<leader>se', function() vim.cmd.Pick 'explorer' end,  desc = '[MiniPick] Explorer' },
      { '<leader>sf', function() vim.cmd.Pick 'files' end,     desc = '[MiniPick] Files' },
      { '<leader>s/', function() vim.cmd.Pick 'grep_live' end, desc = '[MiniPick] Grep' },
      { '<leader>ss', ':Pick lsp scope="document_symbol"<CR>', desc = '[MiniPick] Document Symbols' },
    },
  },

  {
    "FabijanZulj/blame.nvim",
    config = function()
      require("blame").setup()
    end
  },

  {
    'brenoprata10/nvim-highlight-colors',
    config = function()
      require('nvim-highlight-colors').setup {
        render = 'virtual',
      }
    end
  },

  "sindrets/diffview.nvim"

}
