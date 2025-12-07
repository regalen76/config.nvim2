return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local colors = {
      blue = "#80a0ff",
      cyan = "#79dac8",
      black = "#181616",
      white = "#c6c6c6",
      red = "#ff5189",
      violet = "#d183e8",
      grey = "#303030",
    }

    local bubbles_theme = {
      normal = {
        a = { fg = colors.black, bg = colors.violet },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.white },
      },

      insert = { a = { fg = colors.black, bg = colors.blue } },
      visual = { a = { fg = colors.black, bg = colors.cyan } },
      replace = { a = { fg = colors.black, bg = colors.red } },

      inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.white },
      },
    }

    require("lualine").setup({
      options = {
        theme = bubbles_theme,
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
        lualine_b = { "filename", "branch" },

        -- Center section: spacer + Copilot/sidekick status
        lualine_c = {
          "%=", -- keeps things centered

          -- Copilot status
          {
            function()
              return " "
            end,
            color = function()
              local ok, sidekick_status = pcall(require, "sidekick.status")
              if not ok then
                return
              end
              local status = sidekick_status.get()
              if status then
                if status.kind == "Error" then
                  return "DiagnosticError"
                elseif status.busy then
                  return "DiagnosticWarn"
                else
                  return "Special"
                end
              end
            end,
            cond = function()
              local ok, sidekick_status = pcall(require, "sidekick.status")
              if not ok then
                return false
              end
              return sidekick_status.get() ~= nil
            end,
          },
        },

        -- Right side sections
        lualine_x = {
          -- CLI session status
          {
            function()
              local status = require("sidekick.status").cli()
              return " " .. (#status > 1 and #status or "")
            end,
            cond = function()
              return #require("sidekick.status").cli() > 0
            end,
            color = function()
              return "Special"
            end,
          },
        },
        lualine_y = { "filetype", "progress" },
        lualine_z = {
          { "location", separator = { right = "" }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
      tabline = {},
      extensions = {},
    })
  end,
}
