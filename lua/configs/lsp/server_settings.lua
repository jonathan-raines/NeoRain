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
            indent_style = 'spaces',
            indent_size = '2',
            quote_style = 'single',
            call_arg_parentheses = 'remove',
            continuation_indent_size = '2',
            max_line_length = '140',
            continuous_assign_table_field_align_to_equal_sign = 'false'
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
