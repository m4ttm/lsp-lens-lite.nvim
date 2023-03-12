local M = {}

M.buffer_requesting = {}

---Shallow merge two table
---@param tbl1 table
---@param tbl2 table
---@return table merged_table
function M:merge_table(tbl1, tbl2)
  local ret = {}
  for _, item in pairs(tbl1 or {}) do
    table.insert(ret, item)
  end
  for _, item in pairs(tbl2 or {}) do
    table.insert(ret, item)
  end
  return ret
end

---Return index if given bufnr is doing request, -1 otherwise
---@param bufnr integer
---@return integer is_buf_requesting
function M:is_buf_requesting(bufnr)
  for idx, num in ipairs(M.buffer_requesting) do
    if num == bufnr then
      return idx
    end
  end
  return -1
end

---Set given bugnr is requesting, method 0 for begin request and method 1 for request end.
---@param bufnr integer
---@param method integer
function M:set_buf_requesting(bufnr, method)
  if method == 0 then
    table.insert(M.buffer_requesting, bufnr)
  else
    table.remove(M.buffer_requesting, M:is_buf_requesting(bufnr))
  end
end

return M
