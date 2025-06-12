return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    -- bridges the gap between mason and lspconfig
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            -- Load the wezterm types when the `wezterm` module is required
            -- Needs `justinsgithub/wezterm-types` to be installed
            { path = "wezterm-types",      mods = { "wezterm" } },
          },
        },
      },
      -- Support for dart hot-reload on save
      { "RobertBrunhage/dart-tools.nvim" },
      { "saghen/blink.cmp" },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = {
          -- dart sdk ships with LSP
          "lua_ls",
          "zls",
          "pyright",
          "clangd",
        },
      })

      -- Lua Set up
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("my.lsp", {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          if not client then
            return
          end

          if client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })

      -- Python setup
      lspconfig.pyright.setup({ capabilities = capabilities })
      -- Clangd setup
      lspconfig.clangd.setup({ capabilities = capabilities })

      -- Zig Language Server Set up
      lspconfig.zls.setup({ capabilities = capabilities })

      vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format()
      end, { desc = "[F]ormat current buffer" })
      -- vim.lsp.enable('dartls')

      -- Dart Set up
      local dartExcludedFolders = {
        vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
        vim.fn.expand("$HOME/.pub-cache"),
        vim.fn.expand("/opt/homebrew/"),
        vim.fn.expand("$HOME/tools/flutter/"),
      }

      lspconfig.dartls.setup({
        capabilities = capabilities,

        cmd = {
          "dart",
          "language-server",
          "--protocol=lsp",
        },
        filetypes = { "dart" },
        init_options = {
          onlyAnalyzeProjectsWithOpenFiles = false,
          suggestFromUnimportedLibraries = true,
          closingLabels = true,
          outline = true,
          flutterOutline = true,
        },
        settings = {
          dart = {
            analysisExcludedFolders = dartExcludedFolders,
            updateImportsOnRename = true,
            completeFunctionCalls = true,
            showTodos = true,
          },
        },
      })

      --- Setup Ziggy and Zine stuffs
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("ziggy", {}),
        pattern = "ziggy",
        callback = function()
          vim.lsp.start({
            name = "Ziggy LSP",
            cmd = { "ziggy", "lsp" },
            root_dir = vim.loop.cwd(),
            flags = { exit_timeout = 1000 },
          })
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("ziggy_schema", {}),
        pattern = "ziggy_schema",
        callback = function()
          vim.lsp.start({
            name = "Ziggy LSP",
            cmd = { "ziggy", "lsp", "--schema" },
            root_dir = vim.loop.cwd(),
            flags = { exit_timeout = 1000 },
          })
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("superhtml", {}),
        pattern = "superhtml",
        callback = function()
          vim.lsp.start({
            name = "SuperHTML LSP",
            cmd = { "superhtml", "lsp" },
            root_dir = vim.loop.cwd(),
            flags = { exit_timeout = 1000 },
          })
        end,
      })
      vim.lsp.enable("ziggy_schema")
      vim.lsp.enable("ziggy")
      vim.lsp.enable("superhtml")
    end,
  },
}
