return {
  -- "stevearc/conform.nvim",
  -- event = { "BufReadPre", "BufNewFile" },
  -- config = function()
  --   local conform = require("conform")

<<<<<<< HEAD
    conform.setup({
      formatters = {
        ziggy = {
          inherit = false,
          command = "ziggy",
          stdin = true,
          args = { "fmt", "--stdin" },
        },
        ziggy_schema = {
          inherit = false,
          command = "ziggy",
          stdin = true,
          args = { "fmt", "--stdin-schema" },
        },
        superhtml = {
          inherit = false,
          command = "superhtml",
          stdin = true,
          args = { "fmt", "--stdin-super" },
        },
      },
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
        python = { "black" },
        ziggy = { "ziggy" },
        ziggy_schema = { "ziggy_schema" },
        superhtml = { "superhtml" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })
=======
  --   conform.setup({
  --     formatters_by_ft = {
  --       javascript = { "prettier" },
  --       typescript = { "prettier" },
  --       svelte = { "prettier" },
  --       css = { "prettier" },
  --       html = { "prettier" },
  --       json = { "prettier" },
  --       yaml = { "prettier" },
  --       markdown = { "prettier" },
  --       graphql = { "prettier" },
  --       liquid = { "prettier" },
  --       lua = { "stylua" },
  --       python = { "black" },
  --     },
  --     format_on_save = {
  --       lsp_fallback = true,
  --       async = false,
  --       timeout_ms = 1000,
  --     },
  --   })
>>>>>>> 0426ef8 (yet another change)

  --   vim.keymap.set({ "n", "v" }, "<leader>mp", function()
  --     conform.format({
  --       lsp_fallback = true,
  --       async = false,
  --       timeout_ms = 1000,
  --     })
  --   end, { desc = "Format file or range (in visual mode)" })
  -- end,
}
