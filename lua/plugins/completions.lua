return {
	"saghen/blink.cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	-- optional: provides snippets for the snippet source
	dependencies = {
		"rafamadriz/friendly-snippets",
		-- you also need lazydev itself
		"folke/lazydev.nvim",
	},

	-- use a release tag to download pre-built binaries
	version = "1.*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = "default" },

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			menu = {
				border = "rounded",
				winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
			},
			documentation = {
				window = {
					border = "rounded",
				},
				auto_show = true,
			},
		},

		sources = {
			-- lazydev added as first provider
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },

			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority
					score_offset = 100,
				},
			},
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},

	-- still fine to keep if you extend sources elsewhere
	opts_extend = { "sources.default" },
}
