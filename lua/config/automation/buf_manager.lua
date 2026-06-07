local M = {}

local exclude = {
  nvim_tree = true,
  neo_tree = true,
  fern = true,
  vista = true,
  lir = true,
}

local api = vim.api
local MAX_BUFS = 6
local STALE_SECS = 300
local buf_last_viewed = {}

local function is_excluded(bufnr)
  if not api.nvim_buf_is_valid(bufnr) then
    return true
  end

  local bo = vim.bo[bufnr]

  if exclude[bo.filetype] then
    return true
  end

  if bo.buftype ~= "" then
    return true
  end

  if not bo.buflisted then
    return true
  end

  return false
end

local function try_close(bufnr)
  if not vim.bo[bufnr].modified then
    pcall(api.nvim_buf_delete, bufnr, { force = false })
    buf_last_viewed[bufnr] = nil
  end
end

function M.register()
  local group = api.nvim_create_augroup("SingleBuffer", { clear = true })

  api.nvim_create_autocmd("BufEnter", {
    group = group,

    callback = function(args)
      local current = args.buf
      buf_last_viewed[current] = os.time()

      if is_excluded(current) then
        return
      end

      vim.schedule(function()
        local now = os.time()
        local tracked = {}

        for _, bufnr in ipairs(api.nvim_list_bufs()) do
          if bufnr ~= current and not is_excluded(bufnr) then
            local last = buf_last_viewed[bufnr] or 0
            if now - last > STALE_SECS then
              try_close(bufnr)
            else
              table.insert(tracked, { bufnr = bufnr, last = last })
            end
          end
        end

        if #tracked + 1 > MAX_BUFS then
          table.sort(tracked, function(a, b)
            return a.last < b.last
          end)
          for _, entry in ipairs(tracked) do
            if #tracked + 1 <= MAX_BUFS then
              break
            end
            try_close(entry.bufnr)
            table.remove(tracked, 1)
          end
        end
      end)
    end,
  })
end

return M
