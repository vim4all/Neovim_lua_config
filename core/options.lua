vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('data') .. '/undo'

vim.opt.cmdheight = 1
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

vim.opt.colorcolumn = "80"
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

vim.opt.exrc = true


-- Reload files changed outside nvim (Claude, git checkout) when nvim gets focus
-- back or you switch buffers. A buffer with unsaved edits is never replaced:
-- nvim warns instead. FocusGained needs tmux's focus-events (on in .tmux.conf).
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "TermLeave" }, {
    group = vim.api.nvim_create_augroup("autoread_checktime", { clear = true }),
    callback = function()
        if vim.fn.mode() ~= "c" and vim.fn.getcmdwintype() == "" then
            vim.cmd("silent! checktime")
        end
    end,
})
