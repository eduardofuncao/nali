local function sort_by_context_with_spacing(opts)
  local line1 = opts.line1
  local line2 = opts.line2
  -- Get the lines in the range
  local lines = vim.api.nvim_buf_get_lines(0, line1 - 1, line2, false)
  -- Sort lines by context
  table.sort(lines, function(a, b)
    local context_a = a:match('@(%w+)')
    local context_b = b:match('@(%w+)')
    if context_a and context_b then
      return context_a < context_b
    end
    return a < b
  end)
  -- Add blank lines between different contexts
  local result = {}
  local prev_context = nil
  for _, line in ipairs(lines) do
    local context = line:match('@(%w+)')
    -- Add blank line if context changed (and not the first line)
    if context and prev_context and context ~= prev_context then
      table.insert(result, '')
    end
    table.insert(result, line)
    prev_context = context
  end
  -- Replace the lines in the buffer
  vim.api.nvim_buf_set_lines(0, line1 - 1, line2, false, result)
end

vim.api.nvim_create_user_command('Sortc', sort_by_context_with_spacing, {
  range = '%',
})
