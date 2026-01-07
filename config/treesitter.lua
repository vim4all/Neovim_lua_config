local ok, ts_configs = pcall(require, "nvim-treesitter")

ts_configs.setup({
    ensure_installed = { "python", "lua", "c", "markdown", "vim" }, -- languages
    highlight = { enable = true },     -- enable syntax highlighting
    indent = { enable = true },        -- enable smart indentation
    auto_install = true,               -- automatically install missing parsers
})

