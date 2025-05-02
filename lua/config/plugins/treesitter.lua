return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      local install = require("nvim-treesitter.install")
      install.compilers = { "zig" }

      configs.setup({
        ensure_installed = { "c", "dart", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "zig" },
        sync_install = false,
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end
        },
        indent = { enable = true },
      })
    end
  }
}
