vim.g.vimtex_view_method = "sumatrapdf"
vim.g.vimtex_compiler_method = "latexmk"


-- keymaps
local map = vim.keymap.set
map("n", "<Leader>gf", ":Telescope git_files<CR>")


-- Bold
vim.keymap.set('x', '<leader>lb', [[c\textbf{<C-r>"}<Esc>]], {desc = "Bold selected text"})
vim.keymap.set('n', '<leader>lb', [[ciw\textbf{<C-r>"}<Esc>]], {desc="Bold word under cursor"})


vim.keymap.set('x', '<leader>lh', [[c\textcolor{red}{<C-r>"}<Esc>]], {desc = "Higlight selected text"})
vim.keymap.set('n', '<leader>lh', [[ciw\textcolor{red}{<C-r>"}<Esc>]], {desc="Higlight word under cursor"})

-- Italic
-- vim.keymap.set('x', '<leader>ii', [[:s/\%V\(.*\)/\\textit{\1}/<CR>]], {desc = "Italic selected text"})
-- vim.keymap.set('n', '<leader>ii', [[:normal viw<cmd>lua vim.fn.feedkeys('c\\textit{'..vim.fn.expand('<cword>')..'}\<Esc>')<CR>]], {desc="Italic word under cursor"})
