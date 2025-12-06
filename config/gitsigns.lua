-- ======================================
-- GITSIGNS CONFIGURATION
-- ======================================

require("gitsigns").setup({
    signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
    },

    current_line_blame = true,

    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = vim.keymap.set

        -- Hunk actions
        map('n', '<leader>hs', gs.stage_hunk,          { buffer = bufnr })
        map('n', '<leader>hu', gs.undo_stage_hunk,     { buffer = bufnr })
        map('n', '<leader>hr', gs.reset_hunk,          { buffer = bufnr })
        map('n', '<leader>hp', gs.preview_hunk,        { buffer = bufnr })
        map('n', '<leader>hb', gs.toggle_current_line_blame, { buffer = bufnr })

        -- Navigation
        map('n', '<leader>hn', gs.next_hunk,           { buffer = bufnr })
        map('n', '<leader>hp', gs.prev_hunk,           { buffer = bufnr })
    end,
})

