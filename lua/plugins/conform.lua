return {
	"stevearc/conform.nvim",
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>cf",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" }, -- jsx
				typescriptreact = { "prettierd" }, -- tsx
				json = { "prettierd" },
				jsonc = { "prettierd" },
				html = { "prettierd" },
				htmlangular = { "prettierd" },
				prisma = { "prisma_fmt" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})
	end,
}
