local lint = require("lint")

lint.linters_by_ft = {
  python = { "flake8" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  callback = function()
    lint.try_lint()
  end,
})
