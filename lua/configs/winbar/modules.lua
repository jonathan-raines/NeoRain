local folder_icon = require('icons').symbol_kinds.Folder

local M = {}

function M.git_changes()
  if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
    return ''
  end

  local git_status = vim.b.gitsigns_status_dict

  local added = (git_status.added and git_status.added ~= 0) and ('%#GitSignsAdd#' .. '   ' .. git_status.added) or ''
  local changed = (git_status.changed and git_status.changed ~= 0) and
      ('%#GitSignsChange#' .. '   ' .. git_status.changed
      ) or ''
  local removed = (git_status.removed and git_status.removed ~= 0) and
      ('%#GitSignsDelete#' .. '   ' .. git_status.removed
      ) or ''

  return table.concat { added, changed, removed }
end

--- Window bar that shows the current file path (in a fancy way).
---@return string
function M.render()
  -- Get the path and expand variables.
  local path = vim.fs.normalize(vim.fn.expand '%:p' --[[@as string]])

  -- Replace slashes by arrows.
  local separator = ' %#WinbarSeparator# '

  local prefix, prefix_path = '', ''

  -- If the window gets too narrow, shorten the path and drop the prefix.
  if vim.api.nvim_win_get_width(0) < math.floor(vim.o.columns / 3) then
    path = vim.fn.pathshorten(path)
  else
    -- For some special folders, add a prefix instead of the full path (making
    -- sure to pick the longest prefix).
    ---@type table<string, string>
    local special_dirs = {
      CODE = vim.g.projects_dir,
      -- stylua: ignore
      DOTFILES = vim.fn.stdpath 'config' --[[@as string]],
      HOME = vim.env.HOME,
      PERSONAL = vim.g.personal_projects_dir,
    }
    for dir_name, dir_path in pairs(special_dirs) do
      if vim.startswith(path, vim.fs.normalize(dir_path)) and #dir_path > #prefix_path then
        prefix, prefix_path = dir_name, dir_path
      end
    end
    if prefix ~= '' then
      path = path:gsub('^' .. prefix_path, '')
      prefix = string.format('%%#WinbarSpecial#%s %s%s', folder_icon, prefix, separator)
    end
  end

  -- Remove leading slash.
  path = path:gsub('^/', '')

  return table.concat {
    ' ',
    prefix,
    table.concat(
      vim.iter(vim.split(path, '/'))
      :map(function(segment)
        return string.format('%%#Winbar#%s', segment)
      end)
      :totable(),
      separator
    ),
    '%#Winbar#%=',
    M.git_changes(),
  }
end

return M
