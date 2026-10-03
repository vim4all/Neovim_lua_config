local clang_style = require("config.clang_style")

require("conform").setup({
  formatters = {
    ["clang-format"] = {
      prepend_args = function(_, ctx)
        return { clang_style.arg(ctx.buf) }
      end,
    },
  },
  formatters_by_ft = {
    lua    = { "stylua" },
    python = { "black" },
    c      = { "clang-format" },
    cpp    = { "clang-format" },
  },
})

-- <leader>cf and the c/cpp equalprg are set in core/plugins.lua so they work before conform loads
