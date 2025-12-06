-- ======================================
-- NEOGIT CONFIGURATION
-- ======================================

local neogit = require("neogit")

neogit.setup({
    disable_commit_confirmation = true,
    kind = "tab", -- open Neogit in a separate tab
    signs = {
        section = { "", "" },
        item = { "", "" },
    },
})

-- Keymaps for Neogit
local map = vim.keymap.set
map("n", "<leader>gg", ":Neogit<CR>", { silent = true })
map("n", "<leader>gs", ":Neogit kind=split<CR>", { silent = true })
map("n", "<leader>gc", ":Neogit commit<CR>", { silent = true })
map("n", "<leader>gp", ":Neogit push<CR>", { silent = true })
map("n", "<leader>gl", ":Neogit pull<CR>", { silent = true })

