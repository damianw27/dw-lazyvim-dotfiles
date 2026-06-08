local M = {}

function M.init()
  require("nvim-treesitter.install").compilers = {
    "zig",
    "clang",
    "gcc",
  }
end

return M
