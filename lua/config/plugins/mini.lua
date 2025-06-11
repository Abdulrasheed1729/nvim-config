return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      -- Setup statusline
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = true })

      -- Set up mini.diff
      local diff = require("mini.diff")
      diff.setup({})

      -- Set up mini.notify
      local notify = require("mini.notify")
      notify.setup({})
      local opts = { ERROR = { duration = 5000 } }
      vim.notify = notify.make_notify(opts)
    end,
  },
}
