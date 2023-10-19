vim.api.nvim_create_autocmd("VimEnter", {
  desc = 'Set highlights for Statusline',
  pattern = '*',
  callback = function()
    require 'configs.statusline.colors'.set_hl()
  end,
  group = vim.api.nvim_create_augroup('Statusline', { clear = true })
})

local utils = require 'configs.statusline.modules'

--- Sets up the statusline
---@return string
function Statusline()
  return table.concat {
    utils.Mode(),
    utils.Spacer(),
    utils.Git(),
    utils.Spacer(),
    '%=',
    utils.FileInfo(),
    -- utils.Grapple(),
    utils.Spacer(),
    utils.AlternateFile(),
    '%=',
    utils.Package_Updates(),
    utils.LSP_Diagnostics(),
    utils.LSP_status(),
    utils.Spacer(),
    utils.Treesitter(),
    utils.Spacer()
  }
end

vim.o.statusline = '%!v:lua.Statusline()'

