require("cmp").setup({
  formatting = {
    format = function(entry, vim_item)
      local highlights_info = require("colorful-menu").cmp_highlights(entry)

      if highlights_info ~= nil then
        vim_item.abbr_hl_group = highlights_info.highlights
        vim_item.abbr = highlights_info.text
      end

      return vim_item
    end,
  },
})
