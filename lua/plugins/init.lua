return {
  {
    'stevearc/oil.nvim',
    dependencies = "echasnovski/mini.icons",
    init = function()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
    config = function()
      require 'oil'.setup {}
    end
  }

}
