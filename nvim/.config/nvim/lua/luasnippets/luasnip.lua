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
	s("old-checkbox", {
		f(dynamic_flag_name, {}),
		i(1, "_checkbox_name: {"),
		t(": {"),
	}),
})

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
				i(3, "display_value_key"),
				t("display_type: 'input_field'"),
				i(4, "category"),
				i(5, "sub_category"),
			}
		)
	),
})

-- Example snippet for an object with multi-line support
ls.add_snippets("lua", {
	s(
		"obj",
		fmt(
			[[
    local {} = {{
      key1 = {},
      key2 = {},
      key3 = {{
        subkey1 = {},
        subkey2 = {},
      }},
    }}
  ]],
			{
				i(1, "object_name"),
				i(2, "value1"),
				i(3, "value2"),
				i(4, "subvalue1"),
				i(5, "subvalue2"),
			}
		)
	),
})
