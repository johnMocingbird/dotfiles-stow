return {
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		build = (not LazyVim.is_win())
				and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
			or nil,
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = { "~/.config/nvim/lua/snippets/" },
			})
			require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/lua/luasnippets/" } })
		end,
		dependencies = {
			{
				"rafamadriz/friendly-snippets",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load({
						exclude = { "ruby", "rb" },
					})
				end,
			},
			{
				"nvim-cmp",
				dependencies = {
					"saadparwaiz1/cmp_luasnip",
				},
				opts = function(_, opts)
					opts.snippet = {
						expand = function(args)
							require("luasnip").lsp_expand(args.body)
						end,
					}
					table.insert(opts.sources, { name = "luasnip" })
				end,
			},
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
	},
	{
		"nvim-cmp",
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<M-Down>", function() require("luasnip").change_choice(1) end, mode = { "i", "s" } },
      { "<M-Up>", function() require("luasnip").change_choice(-1) end, mode = { "i", "s" } },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
	},
	{
		"garymjr/nvim-snippets",
		enabled = false,
	},
}
