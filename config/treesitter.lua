require("nvim-treesitter.configs").setup({
    ensure_installed = { "python", "lua", "c", "markdown", "vim" },
    highlight = { enable = true },
    indent = { enable = true },
    auto_install = true,
})
