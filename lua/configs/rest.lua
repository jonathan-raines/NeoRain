local status_ok, rest_nvim = pcall(require, 'rest-nvim')
if not status_ok then
  return
end

rest_nvim.setup {
  result_split_horizontal = false,
  skip_ssl_verification = false,
  highlight = {
    enabled = true,
    timeout = 150,
  },
  jump_to_request = true,
}

vim.api.nvim_set_keymap('n', '<C-q>', "<cmd>lua require'rest-nvim'.run()<CR>", { silent = true, noremap = true })
