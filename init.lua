require("config.lazy")

local notify = require("config.notify.warn_me")

vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 8

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>", { desc = "Source configuration" })
vim.keymap.set("n", "<space>x", ":.lua<CR>", { desc = "Source current line" })
vim.keymap.set("v", "<space>x", ":lua<CR>", { desc = "Source current line [Visual mode]" })
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>", { desc = "Go to next quickfix item" })
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>", { desc = "Go to previous quickfix item" })
-- Add oli.nvim
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open oil" })
-- Discpline myself
--
vim.keymap.set({ "n", "v" }, "<Up>", function()
  vim.keymap.set({ "n", "v" }, "<Down>", function()
    notify.warn("Use j you noob!!")
  end)
  vim.keymap.set({ "n", "v" }, "<Right>", function()
    notify.warn("Use l you noob!!")
  end)
  vim.keymap.set({ "n", "v" }, "<Left>", function()
    notify.warn("Use h you noob!!")
  end)
  notify.warn("Use k you noob!!")
end)

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- vim.keymap.set(
-- Set the shell to powershell on windows
if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.opt.shell = "pwsh"
  vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
