return {
	"A7Lavinraj/fyler.nvim",
	dependencies = { "nvim-mini/mini.icons" },
	branch = "stable", -- Use stable branch for production
	opts = {
    views = {
      finder = {
        mappings = {
        ["q"] = "CloseView",
        ["l"] = "Select",
        ["<C-t>"] = "SelectTab",
        ["|"] = "SelectVSplit",
        ["-"] = "SelectSplit",
        ["^"] = "GotoParent",
        ["="] = "GotoCwd",
        ["."] = "GotoNode",
        ["#"] = "CollapseAll",
        ["<BS>"] = "CollapseNode",
      },
      }
    }
  },
	keys = {
		{
			"<leader>e",
			function()
				require("fyler").open({ kind = "float" })
			end,
			desc = "Explorer",
		},
	},
}
