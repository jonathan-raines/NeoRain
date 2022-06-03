vim.g.ftFT_sight_disable = 1 -- if set this, will not have sight line
require 'ftFT'.setup()

local wk_ok, wk = pcall(require, 'which-key')
if wk_ok then
  wk.register {
    d = {
      f = 'Delete to and include',
      F = 'Delete back to and include',
      t = 'Delete to',
      T = 'Delete back to',
    },
  }
end
