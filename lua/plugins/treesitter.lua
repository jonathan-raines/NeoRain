return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "vim", "vimdoc", "query", "ruby" },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<CR>',
          scope_incremental = '<CR>',
          node_incremental = '<TAB>',
          node_decremental = '<S-TAB>'
        },
        is_supported = function()
          local mode = vim.api.nvim_get_mode().mode
          if mode == "c" then
            return false
          end
          return true
        end
      }
    })
  end,
  event = { 'BufNewFile', 'BufReadPre' }
}
