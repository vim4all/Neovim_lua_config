-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- ── Dependencies ──────────────────────────────────────────────────────
  { "nvim-lua/plenary.nvim",       lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ── Colorscheme ───────────────────────────────────────────────────────
  {
    "catppuccin/nvim",
    name     = "catppuccin",
    priority = 1000,
    lazy     = false,
    config   = function() require("config.catppuccin") end,
  },

  -- ── UI ────────────────────────────────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    event  = "VeryLazy",
    config = function() require("config.lualine") end,
  },
  {
    "romgrk/barbar.nvim",
    event        = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config       = function() require("config.barbar") end,
  },
  {
    "folke/which-key.nvim",
    event  = "VeryLazy",
    config = function() require("config.whichkey") end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event  = "BufReadPost",
    config = function() require("config.indent") end,
  },

  -- ── File tree ─────────────────────────────────────────────────────────
  {
    "nvim-tree/nvim-tree.lua",
    cmd    = "NvimTreeToggle",
    keys   = { { "<Leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" } },
    config = function() require("config.nvim-tree") end,
  },

  -- ── Telescope ─────────────────────────────────────────────────────────
  {
    "nvim-telescope/telescope.nvim",
    event  = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
      "ThePrimeagen/git-worktree.nvim",
    },
    config = function() require("config.telescope") end,
  },
  {
    "folke/todo-comments.nvim",
    event        = "BufReadPost",
    dependencies = { "nvim-lua/plenary.nvim" },
    config       = function() require("config.todo-comments") end,
  },

  -- ── Mason ─────────────────────────────────────────────────────────────
  { "williamboman/mason.nvim",           lazy = true },
  { "williamboman/mason-lspconfig.nvim", lazy = true },

  -- ── LSP ───────────────────────────────────────────────────────────────
  {
    "neovim/nvim-lspconfig",
    event        = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("config.mason")
      require("config.lsp")
    end,
  },

  -- ── Formatting ────────────────────────────────────────────────────────
  {
    "stevearc/conform.nvim",
    event  = "BufWritePre",
    cmd    = "ConformInfo",
    config = function() require("config.conform") end,
  },

  -- ── Linting ───────────────────────────────────────────────────────────
  {
    "mfussenegger/nvim-lint",
    event  = { "BufReadPost", "BufWritePost" },
    config = function() require("config.lint") end,
  },

  -- ── Completion ────────────────────────────────────────────────────────
  {
    "hrsh7th/nvim-cmp",
    event  = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "windwp/nvim-autopairs",
    },
    config = function()
      require("config.cmp")
      require("config.autopairs")
    end,
  },

  -- ── Editing ───────────────────────────────────────────────────────────
  {
    "numToStr/Comment.nvim",
    keys   = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
    config = function() require("config.comment") end,
  },

  -- ── Git ───────────────────────────────────────────────────────────────
  {
    "lewis6991/gitsigns.nvim",
    event  = "BufReadPost",
    config = function() require("config.gitsigns") end,
  },
  {
    "TimUntersberger/neogit",
    cmd          = "Neogit",
    keys         = { { "<leader>gg", "<cmd>Neogit<CR>", desc = "Open Neogit" } },
    dependencies = { "nvim-lua/plenary.nvim" },
    config       = function() require("config.neogit") end,
  },

  -- ── DAP ───────────────────────────────────────────────────────────────
  {
    "mfussenegger/nvim-dap",
    keys = { "<F5>", "<F10>", "<F11>", "<F12>", "<F3>", "<Leader>B" },
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function() require("config.dap") end,
  },

  -- ── LaTeX ─────────────────────────────────────────────────────────────
  {
    "lervag/vimtex",
    ft     = "tex",
    config = function() require("config.vimtex") end,
  },

  -- ── Treesitter ────────────────────────────────────────────────────────
  {
    "nvim-treesitter/nvim-treesitter",
    event  = { "BufReadPost", "BufNewFile" },
    build  = ":TSUpdate",
    config = function() require("config.treesitter") end,
  },

  -- ── Misc ──────────────────────────────────────────────────────────────
  { "wakatime/vim-wakatime", event = "VeryLazy" },
})
