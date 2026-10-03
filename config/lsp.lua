-- Applies to every server
vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- Keymaps on attach. Neovim 0.11+ already provides: K (hover), grn (rename),
-- gra (code action), grr (references), gri (implementation), gO (symbols)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
    end
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gD", vim.lsp.buf.declaration, "Go to declaration")
    map("<leader>rn", vim.lsp.buf.rename, "LSP rename")
    map("<leader>ca", vim.lsp.buf.code_action, "LSP code action")
    map("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.name == "clangd" then
      map("<leader>ch", "<cmd>LspClangdSwitchSourceHeader<CR>", "Switch source/header")
    end
  end,
})

vim.diagnostic.config({
  virtual_text = { spacing = 2, source = "if_many" },
  float = { border = "rounded", source = true },
  severity_sort = true,
})

-- clangd: allow the cross toolchains so it picks up their system headers
-- (STM32: arm-none-eabi, ESP32: xtensa-esp*-elf from ~/.espressif)
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=never",
    "--query-driver=/usr/bin/arm-none-eabi-*,"
      .. vim.fn.expand("~") .. "/.espressif/tools/**/xtensa-esp*-elf-*",
  },
})

-- Enable servers (starts them when matching files open)
vim.lsp.enable({
  "lua_ls",
  "pyright",
  "clangd",
  "bashls",
  "neocmake",
})
