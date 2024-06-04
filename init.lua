-- Autocmds ===================================================================
require 'autocommands'

-- Leader key =================================================================
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps ====================================================================
require 'keymaps'

-- Options ====================================================================
require 'options'

-- Statusbar ==================================================================
require 'statusline'

-- Winbar =====================================================================
require 'winbar'

-- Lazy =======================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup('plugins', {
  ui = { border = 'rounded' },
  change_detection = { notify = false },
  checker = { enabled = true, notify = false },
  performance = {
    rtp = {
      -- Stuff I don't use.
      disabled_plugins = {
        'gzip',
        'netrwPlugin',
        'rplugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

-- Colorscheme ================================================================
vim.cmd.colorscheme 'tokyonight'
