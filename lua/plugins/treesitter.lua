return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      ensure_installed = { "lua", "vim", "vimdoc", "query", "ruby" },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        disable = function(_, buf)
          -- Don't disable for read-only buffers.
          if not vim.bo[buf].modifiable then
            return false
          end

          ---@diagnostic disable-next-line: undefined-field
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          -- Disable for files larger than 250 KB.
          return ok and stats and stats.size > (250 * 1024)
        end,
        additional_vim_regex_highlighting = false
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<CR>',
          scope_incremental = '<CR>',
          node_incremental = '<TAB>',
          node_decremental = '<Backspace>'
        },
        is_supported = function()
          local mode = vim.api.nvim_get_mode().mode
          if mode == "c" then
            return false
          end
          return true
        end
      },
      indent = { enable = true },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]]"] = "@function.outer",
            ["]m"] = "@class.outer",
          },
          goto_next_end = {
            ["]["] = "@function.outer",
            ["]M"] = "@class.outer",
          },
          goto_previous_start = {
            ["[["] = "@function.outer",
            ["[m"] = "@class.outer",
          },
          goto_previous_end = {
            ["[]"] = "@function.outer",
            ["[M"] = "@class.outer",
          },
        },
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["ac"] = "@conditional.outer",
            ["ic"] = "@conditional.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
          },
          include_surrounding_whitespace = false,
        },
      },
    }
  end,
  event = { 'BufNewFile', 'BufReadPre' }
}
