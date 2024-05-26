-- Leader key =================================================================
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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

vim.opt.rtp:prepend(lazypath)

require("lazy").setup('plugins', {
  change_detection = {
    enabled = true,
    notify = false,
  },
  checker = {
    enabled = true,
    notify = false,
  },
})

-- Statusbar ==================================================================
require 'configs.statusline'

-- Winbar =====================================================================
require 'configs.winbar'

-- Colorscheme ================================================================
vim.cmd.colorscheme 'onedark'
