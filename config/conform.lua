require("conform").setup({
  formatters_by_ft = {
    lua    = { "stylua" },
    python = { "black" },
    c      = { "clang-format" },
    cpp    = { "clang-format" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })
