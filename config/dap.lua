local dap_ok, dap = pcall(require, "dap")
if dap_ok then

    dap.adapters.python = {
        type = 'executable',
          command = 'python',
          args = { '-m', 'debugpy.adapter' },
    }

    dap.configurations.python = {
        {
            type = 'python',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            console = 'integratedTerminal',
            pythonPath = function() return vim.g.python3_host_prog end,
        },
        {
            type = 'python',
            request = 'launch',
            name = 'Launch module',
            module = '${fileBasenameNoExtension}',
            console = 'integratedTerminal',
            pythonPath = function() return vim.g.python3_host_prog end,
        },
    }

    -- ================================
    -- DAP UI
    -- ================================
    local dapui_ok, dapui = pcall(require, "dapui")
    if dapui_ok then
        dapui.setup({
            icons = { expanded = "▾", collapsed = "▸" },
            controls = { enabled = true },
        })

        dap.listeners.after.event_initialized["dapui_config"] = function() pcall(dapui.open) end
        for _, e in ipairs({ "event_terminated", "event_exited" }) do
            dap.listeners.before[e]["dapui_config"] = function() pcall(dapui.close) end
        end
    end

    -- ================================
    -- DAP Keymaps
    -- ================================
    local keymaps = {
        F5  = dap.continue,
        F10 = dap.step_over,
        F11 = dap.step_into,
        F12 = dap.step_out,
        F3  = dap.toggle_breakpoint,
    }

    for k, fn in pairs(keymaps) do
        vim.keymap.set('n', '<'..k..'>', fn)
    end

    vim.keymap.set('n', '<Leader>B', function()
        dap.set_breakpoint(vim.fn.input('Condition: '))
    end)
end
