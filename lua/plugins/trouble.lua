return {
  "folke/trouble.nvim",
  opts = {}, -- your trouble opts
  cmd = "Trouble",
  specs = {
    "folke/snacks.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts or {}, {
        picker = {
          actions = require("trouble.sources.snacks").actions,
          win = {
            input = {
              keys = {
                -- from Snacks picker -> open current list in Trouble
                ["<c-t>"] = {
                  "trouble_open",
                  mode = { "n", "i" },
                },
              },
            },
          },
        },
      })
    end,
  },
  keys = {
    -- Diagnostics (workspace) via Snacks picker
    {
      "<leader>xx",
      function()
        require("snacks").picker.diagnostics()
      end,
      desc = "Diagnostics (Snacks)",
    },
    -- Buffer diagnostics via Snacks picker
    {
      "<leader>xX",
      function()
        require("snacks").picker.diagnostics_buffer()
      end,
      desc = "Buffer Diagnostics (Snacks)",
    },
    -- Symbols via Snacks picker (document symbols)
    {
      "<leader>cs",
      function()
        require("snacks").picker.lsp_symbols()
      end,
      desc = "Symbols (Snacks)",
    },
    -- LSP “list” via Snacks picker – e.g. references for symbol under cursor
    {
      "<leader>cl",
      function()
        require("snacks").picker.lsp_references()
      end,
      desc = "LSP References (Snacks)",
    },
    -- Location list via Snacks picker
    {
      "<leader>xL",
      function()
        require("snacks").picker.loclist()
      end,
      desc = "Location List (Snacks)",
    },
    -- Quickfix list via Snacks picker
    {
      "<leader>xQ",
      function()
        require("snacks").picker.qflist()
      end,
      desc = "Quickfix List (Snacks)",
    },
  },
}
