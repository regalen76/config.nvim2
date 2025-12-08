---@diagnostic disable: missing-fields
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  event = "VeryLazy",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      -- keep your existing treesitter config here too if you have one
      -- e.g. highlight, indent, etc.
      --
      -- highlight = { enable = true, ... },

      textobjects = {
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist

          -- same keymaps you had in opts.move.keys
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
    })
  end,
}
