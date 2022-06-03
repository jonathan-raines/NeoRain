local M = {}

function M.sumneko_lua()
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
            continuation_indent_size = '2'
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
