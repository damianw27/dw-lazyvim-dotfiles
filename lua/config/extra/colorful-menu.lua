local M = {}

function M.init()
  require("colorful-menu").setup({
    ls = {
      ts_ls = {
        extra_info_hl = "@comment",
      },
      tsserver = {
        extra_info_hl = "@comment",
      },
      vtsls = {
        extra_info_hl = "@comment",
      },
      lua_ls = {
        arguments_hl = "@comment",
      },
      clangd = {
        extra_info_hl = "@comment",
        align_type_to_right = true,
        import_dot_hl = "@comment",
        preserve_type_when_truncate = true,
      },
      zls = {
        align_type_to_right = true,
      },
      fallback = true,
      fallback_extra_info_hl = "@comment",
    },
    fallback_highlight = "@variable",
    max_width = 60,
  })

  require("blink.cmp").setup({
    completion = {
      menu = {
        draw = {
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
          },
        },
      },
    },
  })
end

return M
