-- require todo-comments
require("todo-comments").setup({
  keywords = {
    TODO = { icon = " ", color = "info", alt = { "FIXME", "TASK" } },
    HACK = { icon = " ", color = "warning" },
    NOTE = { icon = " ", color = "hint" },
  },
  highlight = {
    before = "", -- highlight before the keyword
    keyword = "wide", -- highlight the whole keyword
    after = "", -- highlight after the keyword
    pattern = [[.*<(KEYWORDS)\s*:]], -- pattern for highlighting
  },
  search = {
    command = "rg",
    args = { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column" },
    pattern = [[\b(KEYWORDS):]], -- match keywords with colon
  },
})

-- Telescope integration
local telescope = require("telescope")
pcall(telescope.load_extension, "todo-comments")

local map = vim.keymap.set
map("n", "<Leader>ft", ":Telescope todo-comments<CR>", { desc = "List all TODOs" })

