return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },

	-- make sure textobjects is installed
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},

	opts = {
		-- these are your existing settings
		ensure_installed = {
			"lua",
			"vue",
			"html",
			"css",
			"json",
			"tsx",
			"typescript",
			"javascript",
			"prisma",
		},

		highlight = {
			enable = true,
		},

		indent = {
			enable = true,
		},

		-- add textobjects here
		textobjects = {
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist

				goto_next_start = {
					["]f"] = "@function.outer",
					["]c"] = "@class.outer",
					["]a"] = "@parameter.inner",
				},
				goto_next_end = {
					["]F"] = "@function.outer",
					["]C"] = "@class.outer",
					["]A"] = "@parameter.inner",
				},
				goto_previous_start = {
					["[f"] = "@function.outer",
					["[c"] = "@class.outer",
					["[a"] = "@parameter.inner",
				},
				goto_previous_end = {
					["[F"] = "@function.outer",
					["[C"] = "@class.outer",
					["[A"] = "@parameter.inner",
				},
			},
		},
	},

	build = ":TSUpdate",

	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
