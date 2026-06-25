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
    lazy = true,
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
    lazy = true,
    ft = { "antlr", "g4" },
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
  {
    "mbbill/undotree",
    lazy = true,
    cmd = { "UndotreeToggle", "UndotreeShow" },
    keys = {
      { "<leader>uD", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
    },
  },
  {
    "NStefan002/screenkey.nvim",
    version = "*",
    lazy = true,
    cmd = { "Screenkey" },
    keys = {
      { "<leader>uK", "<cmd>Screenkey toggle<cr>", desc = "Toggle Screenkey" },
    },
    opts = {
      clear_after = 2,
      compress_after = 3,
      disable = {
        buftypes = { "terminal", "prompt" },
      },
      group_mappings = true,
      notify_method = "echo",
      win_opts = {
        width = 36,
        height = 3,
      },
    },
  },
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
    "seblyng/roslyn.nvim",
    ft = { "cs" },
    init = function()
      vim.lsp.config("roslyn", {
        settings = {
          ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "openFiles",
            dotnet_compiler_diagnostics_scope = "openFiles",
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
            dotnet_enable_tests_code_lens = true,
          },
          ["csharp|completion"] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = true,
          },
          ["csharp|formatting"] = {
            dotnet_organize_imports_on_format = true,
          },
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
          },
        },
      })
    end,
    opts = {
      broad_search = true,
      filewatching = "auto",
      silent = true,
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
    },
  },
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
          enabled = false,
          filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
        },
        vtsls = {
          settings = {
            typescript = {
              preferences = {
                importModuleSpecifier = "non-relative",
                importModuleSpecifierEnding = "minimal",
              },
            },
          },
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
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")
      if not dap.adapters["netcoredbg"] then
        dap.adapters["netcoredbg"] = {
          type = "executable",
          command = vim.fn.exepath("netcoredbg"),
          args = { "--interpreter=vscode" },
          options = {
            detached = false,
          },
        }
      end
      if not dap.configurations.cs then
        dap.configurations.cs = {
          {
            type = "netcoredbg",
            name = "Launch DLL",
            request = "launch",
            program = function()
              return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-jest",
      "Nsidorenco/neotest-vstest",
      "lawrence-laz/neotest-zig",
    },
    opts = function(_, opts)
      opts = opts or {}
      opts.adapters = opts.adapters or {}
      opts.adapters["neotest-jest"] = opts.adapters["neotest-jest"]
        or {
          cwd = function(path)
            return vim.fs.root(path, { "jest.config.js", "jest.config.ts", "package.json" })
          end,
          jestCommand = "npx jest --runInBand",
        }
      opts.adapters["neotest-vitest"] = opts.adapters["neotest-vitest"] or {}
      opts.adapters["neotest-vstest"] = opts.adapters["neotest-vstest"] or {}
      opts.adapters["neotest-zig"] = opts.adapters["neotest-zig"] or {}
    end,
  },
  {
    "Civitasv/cmake-tools.nvim",
    opts = {
      cmake_compile_commands_options = {
        action = "soft_link",
        target = vim.uv.cwd,
      },
      cmake_executor = {
        name = "overseer",
      },
      cmake_runner = {
        name = "overseer",
      },
      cmake_regenerate_on_save = true,
      cmake_use_preset = true,
      ctest_show_labels = true,
    },
    keys = {
      { "<leader>m", desc = "+cmake" },
      { "<leader>mg", "<cmd>CMakeGenerate<cr>", desc = "CMake Generate" },
      { "<leader>mb", "<cmd>CMakeBuild<cr>", desc = "CMake Build" },
      { "<leader>mr", "<cmd>CMakeRun<cr>", desc = "CMake Run" },
      { "<leader>md", "<cmd>CMakeDebug<cr>", desc = "CMake Debug" },
      { "<leader>mt", "<cmd>CMakeRunTest<cr>", desc = "CMake Run Test" },
      { "<leader>ms", "<cmd>CMakeSettings<cr>", desc = "CMake Settings" },
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
        "codelldb",
        "csharpier",
        "eslint-lsp",
        "lua-language-server",
        "netcoredbg",
        "vtsls",
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
        "c",
        "c_sharp",
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
