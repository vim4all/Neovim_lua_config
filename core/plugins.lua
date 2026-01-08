local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/AppData/Local/nvim/plugged')

-- UI
Plug('folke/which-key.nvim')
Plug('nvim-tree/nvim-web-devicons')
Plug('nvim-lualine/lualine.nvim')
Plug('romgrk/barbar.nvim')
Plug('catppuccin/nvim', { as = 'catppuccin' })

-- File tree
Plug('nvim-tree/nvim-tree.lua')

-- Telescope
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
Plug('nvim-telescope/telescope-file-browser.nvim')
Plug('ThePrimeagen/git-worktree.nvim')
Plug('folke/todo-comments.nvim')

-- Autocomplete
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/cmp-vsnip')
Plug('hrsh7th/vim-vsnip')

-- Git signs
Plug('lewis6991/gitsigns.nvim')
Plug('TimUntersberger/neogit')

-- DAP
Plug('mfussenegger/nvim-dap')
Plug('nvim-neotest/nvim-nio')
Plug('rcarriga/nvim-dap-ui')
Plug('theHamsta/nvim-dap-virtual-text')

-- LaTeX
Plug('lervag/vimtex')

-- Syntax
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('lukas-reineke/indent-blankline.nvim')

-- Programming 
Plug ('wakatime/vim-wakatime')

vim.call('plug#end')
