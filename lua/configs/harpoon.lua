local M = {}

local opts = { silent = true, remap = true }
local keymap = vim.keymap.set

M.setup = function()
  local keymaps = {
    -- { { 'n' }, '<Tab>', '<cmd>Telescope harpoon marks theme=dropdown initial_mode=normal previewer=false<CR>', { desc = 'Telescope harpoon' } },
    { { 'n' }, '<leader>hq', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', { desc = 'File Menu' } },
    { { 'n' }, '<Tab>', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', { desc = 'Harpoon Menu' } },

    { { 'n' }, '<leader>hp', '<cmd>lua require("harpoon.mark").add_file()<CR>', { desc = 'Add File' } },
    { { 'n' }, '<leader>hf', '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', { desc = 'File 1' } },
    { { 'n' }, '<leader>hd', '<cmd>lua require("harpoon.ui").nav_file(2)<CR>', { desc = 'File 2' } },
    { { 'n' }, '<leader>hs', '<cmd>lua require("harpoon.ui").nav_file(3)<CR>', { desc = 'File 3' } },
    { { 'n' }, '<leader>ha', '<cmd>lua require("harpoon.ui").nav_file(4)<CR>', { desc = 'File 4' } },
    { { 'n' }, '<leader>hc', '<cmd>lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>', { desc = 'Command Menu' } },
    { { 'n' }, '<leader>ht', '<cmd>lua require("harpoon.term").gotoTerminal(1)<CR>', { desc = 'Terminal 1' } },
    { { 'n' }, '<leader>hr', '<cmd>lua require("harpoon.term").gotoTerminal(2)<CR>', { desc = 'Terminal 2' } }
  }

  for _, val in pairs(keymaps) do
    keymap(val[1], val[2], val[3], vim.tbl_extend('keep', opts, val[4]))
  end
end

M.config = function()
  require 'harpoon'.setup {
    -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
    enter_on_sendcmd = true,
    -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
    save_on_toggle = false,
    -- set marks specific to each git branch inside git repository
    mark_branch = true,
  }
end

return M
