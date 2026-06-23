local M = {}

M.is_windows = vim.fn.has("win32") == 1
M.is_wsl = vim.fn.has("wsl") == 1
M.is_linux = vim.fn.has("linux") == 1 and not M.is_wsl
M.is_wezterm = vim.env.TERM_PROGRAM == "WezTerm" or vim.env.WEZTERM_EXECUTABLE ~= nil

return M
