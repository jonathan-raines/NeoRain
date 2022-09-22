local M = {}

M.sumneko_lua = function()
  return {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        format = {
          enable = true,
          defaultConfig = {
            indent_style = 'space',
            indent_size = '2',
            quote_style = 'single',
            call_arg_parentheses = 'remove',
            continuation_indent_size = '2',
            max_line_length = '140'
          },
        },
        workspace = {
          library = {
            [vim.fn.expand '$VIMRUNTIME/lua'] = true,
            [vim.fn.stdpath 'config' .. '/lua'] = true,
          },
        },
      },
    },
  }
end

return M
