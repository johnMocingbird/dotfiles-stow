local M = {}

function M.graphql_to_json()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local query = table.concat(lines, "\n")
  local json_query = vim.fn.json_encode({ query = query })
  vim.api.nvim_buf_set_lines(0, 0, -1, false, { json_query })
end

function M.json_to_graphql()
  local line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
  if not line then
    print("Error: Buffer is empty")
    return
  end

  local decoded = vim.fn.json_decode(line)
  if not decoded or not decoded.query then
    print("Error: Invalid JSON or missing 'query' field")
    return
  end

  local query_lines = {}
  for s in decoded.query:gmatch("[^\n]+") do
    table.insert(query_lines, s)
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, query_lines)
end

function M.sync_graphql_to_json()
  local buf_path = vim.api.nvim_buf_get_name(0)
  local file_name = vim.fn.fnamemodify(buf_path, ":t")

  if file_name ~= "query.graphql" then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local query = table.concat(lines, "\n")
  local json_query = vim.fn.json_encode({ query = query })

  local dir = vim.fn.fnamemodify(buf_path, ":h")
  local json_file_path = dir .. "/query.json"

  local file = io.open(json_file_path, "w")
  if file then
    file:write(json_query)
    file:close()
  end
end

return M
