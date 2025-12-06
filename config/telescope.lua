local telescope = require("telescope")

telescope.setup({
  defaults = {
    path_display = { "smart" },
    prompt_prefix = "   ",
    selection_caret = "❯ ",

    sorting_strategy = "ascending",
    layout_strategy = "flex",
    layout_config = {
      horizontal = { preview_width = 0.55 },
      vertical   = { preview_height = 0.40 },
    },

    file_ignore_patterns = {
      "node_modules",
      "%.git/",
      "%.class",
      "__pycache__",
    },

    find_command = { "fd", "--type", "f", "--hidden", "--follow" },
  },

  pickers = {
    find_files = { hidden = true, follow = true },
    live_grep = {
      additional_args = function() return { "--hidden" } end,
    }
  },

  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    git_worktree = {},
  },
})

pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "git_worktree")

-- keymaps
local map = vim.keymap.set
map("n", "<Leader>gf", ":Telescope git_files<CR>")
map("n", "<Leader>gb", ":Telescope git_branches<CR>")
map("n", "<Leader>gc", ":Telescope git_commits<CR>")
map("n", "<Leader>gw", ":Telescope git_worktree git_worktrees<CR>")
map("n", "<Leader>gW", ":Telescope git_worktree create_git_worktree<CR>")
map("n", "<Leader>fch", ":Telescope git_status<CR>")
map("n", "<Leader>ff", ":Telescope find_files<CR>")
map("n", "<Leader>fg", ":Telescope live_grep<CR>")
map("n", "<Leader>fb", ":Telescope buffers<CR>")
map("n", "<Leader>fh", ":Telescope help_tags<CR>")
map("n", "<Leader>fo", ":Telescope oldfiles<CR>")
map("n", "<Leader>sw", ":Telescope grep_string<CR>")
map("n", "<Leader>fe", ":Telescope file_browser<CR>")
