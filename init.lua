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

-- Plugin configs are loaded by lazy.nvim (see core/plugins.lua)
