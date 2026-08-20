local M = {}

local ns
local dimmed_buf

local function line_len(buf, lnum)
  return #vim.api.nvim_buf_get_lines(buf, lnum, lnum + 1, false)[1]
end

local function dim_segments(buf, lnum, segs)
  for _, seg in ipairs(segs) do
    local s, e = seg[1], seg[2]
    if e > s then
      vim.api.nvim_buf_set_extmark(buf, ns, lnum, s, {
        end_line = lnum,
        end_col = e,
        hl_group = "SpotlightDim",
        priority = 4096,
      })
    end
  end
end

local function dim_range(buf, start_l, end_l, start_c, end_c, charwise)
  local total = vim.api.nvim_buf_line_count(buf)
  for l = 0, total - 1 do
    local row = l + 1
    if row < start_l or row > end_l then
      dim_segments(buf, l, { { 0, line_len(buf, l) } })
    elseif charwise and row == start_l and row == end_l then
      dim_segments(buf, l, { { 0, start_c - 1 }, { end_c, line_len(buf, l) } })
    elseif charwise and row == start_l then
      dim_segments(buf, l, { { 0, start_c - 1 } })
    elseif charwise and row == end_l then
      dim_segments(buf, l, { { end_c, line_len(buf, l) } })
    end
  end
end

local function paragraph_range(buf, cur)
  local total = vim.api.nvim_buf_line_count(buf)
  local above = vim.fn.search([[^\s*$]], "bcWn")
  local below = vim.fn.search([[^\s*$]], "cWn")
  local start_l = (above > 0 and above + 1) or 1
  local end_l = (below > 0 and below - 1) or total
  if start_l > end_l then
    start_l, end_l = cur, cur
  end
  return start_l, end_l
end

function M.toggle()
  local buf = vim.api.nvim_get_current_buf()

  if dimmed_buf == buf then
    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    dimmed_buf = nil
    return
  end

  if not ns then
    ns = vim.api.nvim_create_namespace("spotlight_dim")
  end

  if dimmed_buf then
    vim.api.nvim_buf_clear_namespace(dimmed_buf, ns, 0, -1)
    dimmed_buf = nil
  end

  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "\22" then
    local sp = vim.fn.getpos("v")
    local ep = vim.fn.getpos(".")
    if sp[2] > ep[2] or (sp[2] == ep[2] and sp[3] > ep[3]) then
      sp, ep = ep, sp
    end
    dim_range(buf, sp[2], ep[2], sp[3], ep[3], mode == "v")
  else
    local cur = vim.api.nvim_win_get_cursor(0)[1]
    local s, e = paragraph_range(buf, cur)
    dim_range(buf, s, e, 1, 0, false)
  end

  dimmed_buf = buf
end

function M.setup(opts)
  opts = opts or {}

  local function set_hl()
    vim.api.nvim_set_hl(0, "SpotlightDim", { fg = opts.dim_color or "#555555" })
  end
  set_hl()
  vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })

  vim.keymap.set({ "n", "x" }, "<leader>sl", M.toggle, { desc = "Toggle spotlight dim" })
end

return M