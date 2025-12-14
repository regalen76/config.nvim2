return {
	"SmiteshP/nvim-navic",
	lazy = true,
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	opts = {
		highlight = true,
		separator = "  ",
		depth_limit = 5,
		depth_limit_indicator = "…",
		lsp = {
			auto_attach = true,
      preference = { "vue_ls" },
		},
	},
	config = function(_, opts)
		require("nvim-navic").setup(opts)
	end,
}
