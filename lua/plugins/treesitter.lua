return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  main = "nvim-treesitter.configs", -- Sets main module to use for opts
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "diff",
      "rust",
      "zig",
      "dart",
      "html",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "query",
      "vim",
      "vimdoc",
    },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { "ruby" },
    },
    indent = { enable = true, disable = { "ruby" } },
  },
  config = function(_, opts)
    vim.filetype.add({ extension = { dfy = "dafny" } })
    local pc = require("nvim-treesitter.parsers").get_parser_configs()
    pc.dafny = {
      install_info = {
        url = "https://github.com/oscar-bender-stone/tree-sitter-dafny",
        files = { "src/parser.c" },
        -- revision = <sha>, -- commit hash for revision to check out; HEAD if missing
        -- optional entries:
        branch = "main", -- only needed if different from default branch
        -- location = "parser", -- only needed if the parser is in subdirectory of a "monorepo"
        -- generate = true, -- only needed if repo does not contain pre-generated `src/parser.c`
        -- generate_from_json = false, -- only needed if repo does not contain `src/grammar.json` either
        queries = "queries/helix", -- also install queries from given directory
      },
      filetype = "dafny",
    }
    vim.treesitter.language.register("dafny", "dafny")
    -- vim.api.nvim_create_autocmd("FileType", {
    --   pattern = { "dfy" },
    --   callback = function()
    --     vim.treesitter.start()
    --   end,
    -- })
    require("nvim-treesitter.configs").setup(opts)
  end,
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
