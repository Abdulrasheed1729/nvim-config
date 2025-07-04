return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      local install = require("nvim-treesitter.install")
      install.compilers = { "zig" }

      configs.setup({
        ensure_installed = {
          "c",
          "python",
          "dart",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "elixir",
          "heex",
          "javascript",
          "html",
          "zig",
        },
        sync_install = false,
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        indent = { enable = true },
      })

      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

      parser_config.ziggy = {
        install_info = {
          url = "https://github.com/kristoff-it/ziggy",
          includes = { "tree-sitter-ziggy/src" },
          files = { "tree-sitter-ziggy/src/parser.c" },
          branch = "main",
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = "ziggy",
      }

      parser_config.ziggy_schema = {
        install_info = {
          url = "https://github.com/kristoff-it/ziggy",
          files = { "tree-sitter-ziggy-schema/src/parser.c" },
          branch = "main",
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = "ziggy-schema",
      }

      parser_config.supermd = {
        install_info = {
          url = "https://github.com/kristoff-it/supermd",
          includes = { "tree-sitter/supermd/src" },
          files = {
            "tree-sitter/supermd/src/parser.c",
            "tree-sitter/supermd/src/scanner.c",
          },
          branch = "main",
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = "supermd",
      }

      parser_config.supermd_inline = {
        install_info = {
          url = "https://github.com/kristoff-it/supermd",
          includes = { "tree-sitter/supermd-inline/src" },
          files = {
            "tree-sitter/supermd-inline/src/parser.c",
            "tree-sitter/supermd-inline/src/scanner.c",
          },
          branch = "main",
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = "supermd_inline",
      }

      parser_config.superhtml = {
        install_info = {
          url = "https://github.com/kristoff-it/superhtml",
          includes = { "tree-sitter-superhtml/src" },
          files = {
            "tree-sitter-superhtml/src/parser.c",
            "tree-sitter-superhtml/src/scanner.c",
          },
          branch = "main",
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = "superhtml",
      }

      vim.filetype.add({
        extension = {
          smd = "supermd",
          shtml = "superhtml",
          ziggy = "ziggy",
          ["ziggy-schema"] = "ziggy_schema",
        },
      })
    end,
  },
}
