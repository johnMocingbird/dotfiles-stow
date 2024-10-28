-- luasnip.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node

local dynamic_flag_name = function()
	local state = vim.fn.expand("%:t:r")
	local path = vim.fn.expand("%p")
	local directory = path:match(".*/([^/]+)/[^/]+$")
	-- ([^/]+) captures one or more non-slash characters.
	-- $ makes it’s at the end of the string.

	local user_type_map = {
		common_base = "md_do",
		physician = "md",
		doctor_of_osteopathy = "do",
		physician_assistant = "pa",
		nurse_practitioner = "np",
		registered_nurse = "rn",
		behavioral_health = "bh",
		physical_therapist = "pt",
	}

	local user_type = user_type_map[directory]
	return state .. "_" .. user_type .. "_"
end

ls.add_snippets("ruby", {
	s(
		"task-sub-credits",
		fmt(
			[[
      {{ # task {}
        title: '{}',
        description: '{}',
        active_on: 0.months,
        active_till: 0.months,
        interval: {}.years,
        cyclic: true,
        identifier_under_specialty: '{}',
        category_1_sub_credits_flag: %w[{}],
        sub_credit_flags: {{
          from: Certification,
          flag_names: %w[{}]
        }},
        sub_credits: {}
      }},
      ]],
			{
				i(1, "Task_Cell"), -- User input for the task name (X)
				i(2, "Title"), -- User input for the title (X),
				i(3, "description"),
				i(4, "0"), -- User input for the interval (X)
				i(5, "0"), -- User input for identifier (X)
				i(6, "md_do_credits"),
				i(7, "FlagName"), -- note, need to have flag name for singe name flags for arry
				i(8, "0"), --  NOTE: need to have sub_credits main_credits main_categorized_credits
			}
		)
	),
})

-- TODO: add exemption clause
ls.add_snippets("lua", {
	s(
		"",
		fmt(
			[[
      {{

      }},
      ]],
			{}
		)
	),
})

ls.add_snippets("lua", {
	s(
		"fmt_temp",
		fmt(
			[[
      ls.add_snippets("{}", {{
        s(
          "{}",
          fmt(
            [[
            {{{{
              {}
            }}}},
            {}
            {{}}
            )
          ),
        }})
      ]],
			{
				i(1, "language"),
				i(2, "snippet_name"),
				i(3, "snippet_body"),
				t("]],"),
			}
		)
	),
})

-- TODO: create a dynamic way to add flags

ls.add_snippets("ruby", {
	s("md_do_credits", {
		t({
			"%w[",
			"  categorized_main_credits_category_1_ama_pra",
			"  categorized_main_credits_category_2_ama_pra",
			"  categorized_main_category_1_a_aoa",
			"  categorized_main_category_1_b_aoa",
			"  categorized_main_category_2_a_aoa",
			"  categorized_main_category_2_b_aoa",
			"  categorized_main_category_aafp_prescribed",
			"  categorized_main_category_aafp_elective",
			"  categorized_main_category_1_acog_cognate",
			"  categorized_main_category_1_acep",
			"  category_pharmacology_credits",
			"]",
		}),
	}),
})

-- TODO: do something like this, to name the flag name, based on the name of the checkbox
--   local function generate_slug(input)
--   -- Convert to lowercase
--   local result = string.lower(input)
--
--   -- Remove special characters
--   result = result:gsub("[^%w%s]", "")
--
--   -- Replace spaces with underscores
--   result = result:gsub("%s+", "_")
--
--   -- Truncate the string if it exceeds 40 characters
--   local max_length = 40
--   if #result > max_length then
--     result = result:sub(1, max_length)
--   end
--
--   return result
-- end
--

ls.add_snippets("ruby", {
	s(
		"auto-checkbox",
		fmt(
			[[
      {}{}: {{
        display_value: '{}',
        display_type: 'checkbox',
        {}{}_credits: {{
          display_value: '{}',
          {}
        }},
        category: '{}',
        sub_category: ['{}']
      }},
      ]],
			{
				f(dynamic_flag_name),
				i(1, "flag_name"),
				i(2, "display_value_value"),
				f(dynamic_flag_name),
				f(function(args)
					return args[1][1]
				end, { 1 }),
				c(3, {
					t("Number of sub-credits"),
					t("Number of Main Credits"),
					i(nil, ""),
				}),
				t("display_type: 'input_field'"),
				i(4, "category"),
				i(5, "sub_category"),
			}
		)
	),
})
