local notify = require('mini.notify')

local M = {}

M.warn = function(msg, level)
  if not level then
    level = 'WARN'
  end

  local id = notify.add(msg, level)
  vim.defer_fn(function()
    notify.remove(id)
  end, 1000)
end

return M
