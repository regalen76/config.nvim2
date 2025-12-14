
return {
  "bassamsdata/namu.nvim",
  opts = {
    global = {},
    namu_symbols = {
      options = {
        -- choose one:
        display = { format = "tree_guides" },
        -- display = { format = "indent" },
      },
    },
  },
  keys = {
    { "<leader>sss", "<cmd>Namu symbols<cr>", desc = "Jump to LSP symbol", silent = true },
    { "<leader>ssf", "<cmd>Namu symbols function<cr>", desc = "Jump to LSP symbol Function", silent = true },
    { "<leader>ssv", "<cmd>Namu symbols variable<cr>", desc = "Jump to LSP symbol Variable", silent = true },
    { "<leader>ssc", "<cmd>Namu symbols class<cr>", desc = "Jump to LSP symbol Class", silent = true },
    { "<leader>ssm", "<cmd>Namu symbols method<cr>", desc = "Jump to LSP symbol Method", silent = true },
    { "<leader>ssp", "<cmd>Namu symbols property<cr>", desc = "Jump to LSP symbol Property", silent = true },
    { "<leader>sS", "<cmd>Namu workspace<cr>", desc = "LSP Symbols - Workspace", silent = true },
  },
}

