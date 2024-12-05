local M = {}
-- TODO: check to handle grep and find_files

local telescope = require("telescope.builtin")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local grep_directories = {
	{ name = "Migrations", path = "db/migrate" },
	{ name = "Models", path = "app/models" },
	{ name = "Rules - State Licenses", path = "app/models/concerns/tasks/state_licenses/" },
	{ name = "Rules - MD", path = "app/models/concerns/tasks/state_licenses/physician/" },
	{ name = "Rules - DO", path = "app/models/concerns/tasks/state_licenses/doctor_of_osteopathy/" },
	{ name = "Rules - RN", path = "app/models/concerns/tasks/state_licenses/registered_nurse/" },
	{ name = "Rules - BH", path = "app/models/concerns/tasks/state_licenses/behavioral_health/" },
	{ name = "Rules - NP", path = "app/models/concerns/tasks/state_licenses/nurse_practitioner/" },
	{ name = "Rules - PA", path = "app/models/concerns/tasks/state_licenses/physician_assistant/" },
	{ name = "Rules - Common", path = "app/models/concerns/tasks/state_licenses/common_base/" },
}

local function grep_in_directory(selection)
	if selection.name == "Models" then
		telescope.live_grep({
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--max-depth",
				"1",
				selection.path,
			},
			prompt_title = "Grep in " .. selection.name,
		})
	else
		telescope.find_files({
			search_dirs = { selection.path },
			prompt_title = "Grep in " .. selection.name,
		})
	end
end

function M.grep_menu()
	pickers
		.new({}, {
			prompt_title = "Select Directory to Grep",
			finder = finders.new_table({
				results = grep_directories,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry.name,
						ordinal = entry.name,
					}
				end,
			}),
			sorter = sorters.get_generic_fuzzy_sorter(),
			attach_mappings = function(_, map)
				actions.select_default:replace(function(prompt_bufnr)
					local selection = action_state.get_selected_entry(prompt_bufnr)
					actions.close(prompt_bufnr)
					grep_in_directory(selection.value)
				end)
				return true
			end,
		})
		:find()
end

return M
