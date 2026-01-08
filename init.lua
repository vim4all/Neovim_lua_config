-- ============================
-- Neovim Init (modular)
-- ============================
-- top of init.lua, before any require()
local config_path = vim.fn.stdpath("config"):gsub("\\", "/")
package.path = config_path .. "/?.lua;" .. config_path .. "/?/init.lua;" .. package.path:gsub("\\", "/")


-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core
require("core.options")
require("core.keymaps")
require("core.plugins")

-- Plugin configs
require("config.barbar")
require("config.catppuccin")
require("config.nvim-tree")
require("config.lualine")
require("config.whichkey")
require("config.telescope")
require("config.treesitter")
require("config.todo-comments")
require("config.indent")
require("config.vimtex")
require("config.dap")
require("config.gitsigns")
require("config.neogit")
require('config.lsp')
require('config.cmp')
