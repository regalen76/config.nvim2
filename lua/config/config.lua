-- ========== Basic Settings ==========
-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- keep some space above/below cursor (your "max 5 space in bottom")
vim.opt.scrolloff = 5

-- mouse + clipboard
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

-- indentation
vim.opt.tabstop = 2        -- how many spaces a <Tab> displays as
vim.opt.shiftwidth = 2     -- how many spaces to use for indent
vim.opt.expandtab = true   -- use spaces instead of tabs
vim.opt.smartindent = true

-- searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- UI niceties
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.wrap = false

-- splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- invisible chars (optional)
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", trail = "·", nbsp = "␣" }
