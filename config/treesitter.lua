local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
if not ok then
  vim.notify("nvim-treesitter not found!", vim.log.levels.WARN)
  return
end

ts_configs.setup({
    ensure_installed = { "python", "lua", "c", "markdown", "vim" }, -- languages
    highlight = { enable = true },     -- enable syntax highlighting
    indent = { enable = true },        -- enable smart indentation
    auto_install = true,               -- automatically install missing parsers
})

