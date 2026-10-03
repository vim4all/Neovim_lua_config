-- New nvim-treesitter API: setup only accepts { install_dir }
-- Highlighting and indent are handled by neovim's built-in treesitter integration
require("nvim-treesitter").setup()

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft == "" then return end
    local ok, parser = pcall(vim.treesitter.language.inspect, ft)
    if ok and parser then
      pcall(vim.treesitter.start, args.buf)
    end
  end,
})
