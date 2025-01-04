local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add {
  source = 'nvim-treesitter/nvim-treesitter',
  checkout = 'master',
  hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
}

later(function()
  require('nvim-treesitter.configs').setup({
    auto_install = true,
    ensure_installed = { 'lua', 'vimdoc' },
    highlight = { enable = true },
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
    indent = { enable = true }
  })
end
)
