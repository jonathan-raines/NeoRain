local M = {}

function M.jsonls()
  -- Find more schemas here: https://www.schemastore.org/json/
  local schemas = {
    {
      description = 'TypeScript compiler configuration file',
      fileMatch = {
        'tsconfig.json',
        'tsconfig.*.json',
      },
      url = 'https://json.schemastore.org/tsconfig.json',
    },
    {
      description = 'ESLint config',
      fileMatch = {
        '.eslintrc.json',
        '.eslintrc',
      },
      url = 'https://json.schemastore.org/eslintrc.json',
    },
    {
      description = 'Prettier config',
      fileMatch = {
        '.prettierrc',
        '.prettierrc.json',
        'prettier.config.json',
      },
      url = 'https://json.schemastore.org/prettierrc',
    },
    {
      description = 'Stylelint config',
      fileMatch = {
        '.stylelintrc',
        '.stylelintrc.json',
        'stylelint.config.json',
      },
      url = 'https://json.schemastore.org/stylelintrc',
    },
    {
      description = 'Json schema for properties json file for a GitHub Workflow template',
      fileMatch = {
        '.github/workflow-templates/**.properties.json',
      },
      url = 'https://json.schemastore.org/github-workflow-template-properties.json',
    },
    {
      description = 'NPM configuration file',
      fileMatch = {
        'package.json',
      },
      url = 'https://json.schemastore.org/package.json',
    },
  }

  local opts = {
    settings = { json = { schemas = schemas } },
    setup = {
      commands = {
        Format = {
          function()
            vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line '$', 0 })
          end,
        },
      },
    },
  }

  return opts
end

function M.sumneko_lua()
  return {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
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
