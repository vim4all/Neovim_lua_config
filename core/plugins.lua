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
    cmd  = "Telescope",
    keys = {
      "<Leader>ff", "<Leader>fg", "<Leader>fb", "<Leader>fh",
      "<Leader>fo", "<Leader>fe", "<Leader>fr", "<Leader>fs",
      "<Leader>fc", "<Leader>sw",
      "<Leader>gf", "<Leader>gb", "<Leader>gc",
      "<Leader>gw", "<Leader>gW",
    },
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

  -- ── Flash ─────────────────────────────────────────────────────────────
  {
    "folke/flash.nvim",
    event  = "VeryLazy",
    config = function() require("config.flash") end,
  },

  -- ── Mason ─────────────────────────────────────────────────────────────
  { "mason-org/mason.nvim",           lazy = true },
  { "mason-org/mason-lspconfig.nvim", lazy = true },

  -- ── LSP ───────────────────────────────────────────────────────────────
  {
    "neovim/nvim-lspconfig",
    event        = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      require("config.mason")
      require("config.lsp")
    end,
  },

  -- ── Formatting ────────────────────────────────────────────────────────
  {
    "stevearc/conform.nvim",
    cmd    = "ConformInfo",
    keys   = {
      {
        "<leader>cf",
        function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    init   = function()
      -- `=` uses clang-format with the same style resolution as conform
      vim.api.nvim_create_autocmd("FileType", {
        pattern  = { "c", "cpp" },
        callback = function(args)
          vim.opt_local.equalprg = "clang-format " .. require("config.clang_style").arg(args.buf)
        end,
      })
    end,
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
      "windwp/nvim-autopairs",
    },
    config = function()
      require("config.cmp")
      require("config.autopairs")
    end,
  },

  -- ── Git ───────────────────────────────────────────────────────────────
  {
    "lewis6991/gitsigns.nvim",
    event  = "BufReadPost",
    config = function() require("config.gitsigns") end,
  },
  {
    "sindrets/diffview.nvim",
    cmd    = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys   = { { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diffview open" } },
    config = function() require("config.diffview") end,
  },
  {
    "NeogitOrg/neogit",
    cmd          = "Neogit",
    keys         = { { "<leader>gg", "<cmd>Neogit<CR>", desc = "Open Neogit" } },
    dependencies = { "nvim-lua/plenary.nvim" },
    config       = function() require("config.neogit") end,
  },

  -- ── DAP ───────────────────────────────────────────────────────────────
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>dc", function() require("dap").continue() end,          desc = "DAP continue / start" },
      { "<leader>ds", function() require("dap").step_over() end,         desc = "DAP step over" },
      { "<leader>dw", function() require("dap").step_into() end,         desc = "DAP step into" },
      { "<leader>de", function() require("dap").step_out() end,          desc = "DAP step out" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP toggle breakpoint" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,     desc = "DAP run to cursor" },
      { "<leader>dr", function() require("dap").repl.open() end,         desc = "DAP REPL" },
      { "<leader>dl", function() require("dap").run_last() end,          desc = "DAP run last" },
      { "<leader>dq", function() require("dap").terminate() end,         desc = "DAP terminate" },
      { "<leader>du", function() require("dapui").toggle() end,          desc = "DAP toggle UI" },
      { "<leader>dh", function() require("dap.ui.widgets").hover() end,  desc = "DAP inspect value", mode = { "n", "v" } },
      { "<Leader>B",  function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "DAP conditional breakpoint" },
    },
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
}, {
  performance = {
    rtp = {
      -- lazy resets the rtp; keep the distro's bundled treesitter parsers (lua, c, vim, ...)
      paths = { "/usr/lib/x86_64-linux-gnu/nvim" },
    },
  },
})
