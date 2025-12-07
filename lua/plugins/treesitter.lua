return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
	opts = {
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
	},
	build = ":TSUpdate",
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
