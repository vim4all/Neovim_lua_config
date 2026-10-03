require("flash").setup()

local map = vim.keymap.set
map({ "n", "x", "o" }, "s",     function() require("flash").jump() end,              { desc = "Flash jump" })
map({ "n", "x", "o" }, "S",     function() require("flash").treesitter() end,        { desc = "Flash treesitter" })
map("o",               "r",     function() require("flash").remote() end,            { desc = "Flash remote" })
map({ "o", "x" },     "R",     function() require("flash").treesitter_search() end, { desc = "Flash treesitter search" })
map("c",               "<C-s>", function() require("flash").toggle() end,            { desc = "Toggle flash" })
