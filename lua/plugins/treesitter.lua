return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
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
    }
  end,
  event = { 'BufNewFile', 'BufReadPre' }
}
