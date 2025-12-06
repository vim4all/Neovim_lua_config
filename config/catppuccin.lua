require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = false,
    integrations = {
        lualine = true,
        telescope = true,
        treesitter = true,
        dap = true,
        nvimtree = true,
    },
})

vim.cmd.colorscheme "catppuccin"
