-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local os = require("config.extra.os")

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.guifont = "Source Code Pro:16"

vim.opt.colorcolumn = "120"

vim.cmd([[highlight ColorColumn ctermbg=lightgrey guibg=lightgrey]])

vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/site")

if os.is_linux then
  vim.g.clipboard = {
    name = "wl-clipboard",
    copy = {
      ["+"] = "wl-copy",
      ["*"] = "wl-copy",
    },
    paste = {
      ["+"] = "wl-paste --no-newline",
      ["*"] = "wl-paste --no-newline",
    },
    cache_enabled = 1,
  }
elseif os.is_wsl then
  if os.is_wezterm then
    vim.g.clipboard = "osc52"
  elseif vim.fn.executable("win32yank.exe") == 1 then
    vim.g.clipboard = {
      name = "win32yank-wsl",
      copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
      },
      paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf",
      },
      cache_enabled = 0,
    }
  else
    vim.g.clipboard = "osc52"
  end
end

if os.is_windows then
  vim.opt.shell = "pwsh"
  vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end
