return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		automatic_enable = {
			exclude = {
				"rust_analyzer",
				"bacon",
				"bacon-ls",
        "vtsls",
        "vue_ls"
			},
		},
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		{ "neovim/nvim-lspconfig" },
		{ "SmiteshP/nvim-navic" },
	},
}
