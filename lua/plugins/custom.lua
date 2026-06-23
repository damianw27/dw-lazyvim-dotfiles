return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true,
        sources = {
          files = {
            hidden = true, -- Show hidden/dotfiles
          },
        },
      },
      explorer = {
        win = {
          list = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
  },
  {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*", -- Use the latest tagged version
    opts = {}, -- This causes the plugin setup function to be called
    keys = {
      { "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
      { "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "i", "x" }, desc = "Add cursor and move down" },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "LazyVim", words = { "LazyVim" } },
      },
    },
  },
  {
    "lewis6991/async.nvim",
    lazy = true,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    cmd = { "Refactor" },
    dependencies = {
      "lewis6991/async.nvim",
    },
  },
  {
    "tanvirtin/monokai.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("monokai").setup({
        palette = require("monokai").soda,
      })
      vim.cmd.colorscheme("monokai")
    end,
  },
  {
    "dylon/vim-antlr",
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {
      add_messages = {
        display_count = true,
      },
      multilines = {
        enabled = true,
        always_show = true,
      },
      show_source = {
        enabled = true,
      },
    },
  },
  { "rafamadriz/friendly-snippets" },
  { "mbbill/undotree" },
  {
    "nvim-java/nvim-java",
    ft = { "java" },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("java").setup()
      vim.lsp.enable("jdtls")
    end,
  },
  { "xzbdmw/colorful-menu.nvim" },
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts = opts or {}
      opts.fuzzy = opts.fuzzy or {}
      opts.fuzzy.implementation = "lua"
      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or { "lsp", "path", "snippets", "buffer" }
      if not vim.tbl_contains(opts.sources.default, "lazydev") then
        table.insert(opts.sources.default, 1, "lazydev")
      end
      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers.lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      }
      return opts
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = { enabled = false },
        ts_ls = {
          filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
        },
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              diagnostics = {
                globals = { "vim", "LazyVim" },
              },
              telemetry = {
                enable = false,
              },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                },
              },
            },
          },
        },
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--header-insertion=iwyu",
          },
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
        },
        zls = {},
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local lint = require("lint")

      local linters_by_ft = {
        lua = { "luacheck" },
        c = { "clangtidy" },
        cpp = { "clangtidy" },
      }

      local js_linter
      if vim.fn.executable("eslint_d") == 1 then
        js_linter = "eslint_d"
      elseif vim.fn.executable("eslint") == 1 then
        js_linter = "eslint"
      end

      if js_linter then
        for _, ft in ipairs({ "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }) do
          linters_by_ft[ft] = { js_linter }
        end
      end

      lint.linters_by_ft = linters_by_ft
      return {}
    end,
    config = function(_, _)
      local lint = require("lint")
      local group = vim.api.nvim_create_augroup("nvim_lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        group = group,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or {}

      local tools = {
        "clangd",
        "eslint-lsp",
        "lua-language-server",
        "typescript-language-server",
        "zls",
      }

      for _, tool in ipairs(tools) do
        if not vim.tbl_contains(opts.ensure_installed, tool) then
          table.insert(opts.ensure_installed, tool)
        end
      end

      return opts
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts = opts or {}

      local ensure = opts.ensure_installed
      if type(ensure) ~= "table" then
        ensure = {}
      end

      local parsers = {
        "cpp",
        "java",
        "javascript",
        "lua",
        "tsx",
        "typescript",
        "zig",
      }

      for _, parser in ipairs(parsers) do
        if not vim.tbl_contains(ensure, parser) then
          table.insert(ensure, parser)
        end
      end

      opts.ensure_installed = ensure
      opts.highlight = opts.highlight or {}
      opts.highlight.disable = function(_, bufnr)
        return vim.api.nvim_buf_line_count(bufnr) > 20000
      end

      return opts
    end,
  },
  {
    "oclay1st/maven.nvim",
    cmd = { "Maven", "MavenInit", "MavenExec", "MavenFavorites" },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {}, -- options, see default configuration
    keys = {
      { "<leader>M", desc = "+Maven", mode = { "n", "v" } },
      { "<leader>Mm", "<cmd>Maven<cr>", desc = "Maven Projects" },
      { "<leader>Mf", "<cmd>MavenFavorites<cr>", desc = "Maven Favorite Commands" },
    },
  },
}
