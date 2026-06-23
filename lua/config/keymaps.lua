-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local os = require("config.extra.os")

if os.is_windows or os.is_wsl then
  vim.keymap.set({ "n", "i", "v", "c", "t" }, "<f15>", "<nop>", { silent = true })
  vim.keymap.set({ "n", "i", "v", "c", "t" }, "<F16>", "<Nop>", { silent = true })
end
