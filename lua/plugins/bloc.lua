return {
  "wa11breaker/flutter-bloc.nvim",
  dependencies = {
    "nvimtools/none-ls.nvim", -- Required for code actions
  },
  opts = {
    bloc_type = "default", -- Choose from: 'default', 'equatable', 'freezed'
    use_sealed_classes = false,
    enable_code_actions = true,
  },
  config = function()
    -- Create BLoC quickly
    vim.keymap.set("n", "<Leader>cfb", "<cmd>lua require('flutter-bloc').create_bloc()<cr>", {
      desc = "[C]reate [F]lutter [B]loc",
    })

    -- Create Cubit quickly
    vim.keymap.set("n", "<Leader>cfc", "<cmd>lua require('flutter-bloc').create_cubit()<cr>", {
      desc = "[C]reate [F]lutter [C]ubit",
    })
  end,
}
