local M = {}
function M.open_rspec_file()
	local current_file = vim.fn.expand("%:p")
	local spec_file = current_file
		:gsub("/app/models/concerns/tasks/", "/spec/models/concerns/") -- Replace and remove 'tasks'
		:gsub("%.rb$", "_spec.rb") -- Change `.rb` to `_spec.rb`

	-- Check if the RSpec file exists
	if vim.fn.filereadable(spec_file) == 1 then
		vim.cmd("edit " .. spec_file)
	else
		print("RSpec file not found: " .. spec_file)
	end
end
return M
