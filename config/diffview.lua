require("diffview").setup()

local map = vim.keymap.set
map("n", "<leader>gd", "<cmd>DiffviewOpen<CR>",          { desc = "Diffview open" })
map("n", "<leader>gD", "<cmd>DiffviewClose<CR>",         { desc = "Diffview close" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "File history (current)" })
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<CR>",   { desc = "Branch history" })
