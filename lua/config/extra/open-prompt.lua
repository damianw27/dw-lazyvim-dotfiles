local M = {}

function M.init()
  local grammar_path = vim.fn.resolve("/files/Projects/AI/open-prompt/modules/tree-sitter")

  require("nvim-treesitter.parsers").openprompt = {
    install_info = {
      url = "https://github.com/damianw27/open-prompt",
      branch = "main",
      location = "modules/tree-sitter",
      generate = true,
      queries = "queries",
      files = { "src/parser.c", "src/scanner.c", "src/tree_sitter/parser.h" },
    },
    filetype = "openprompt",
  }

  vim.treesitter.language.register("openprompt", { "op", "openprompt", "prompt" })

  vim.filetype.add({
    extension = {
      openprompt = "openprompt",
      op = "openprompt",
      prompt = "openprompt",
    },
  })

  vim.lsp.config("openprompt", {
    cmd = { "openprompt-lsp" },
    filetypes = { "openprompt" },
    root_markers = { ".git" },
  })
  vim.lsp.enable("openprompt")
end

return M
