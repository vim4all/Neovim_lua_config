local dap_ok, dap = pcall(require, "dap")
if not dap_ok then return end

-- ================================
-- Python Adapter
-- ================================
dap.adapters.python = {
    type = 'executable',
    command = vim.g.python3_host_prog,
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
-- C++ Adapter (local GDB)
-- ================================
dap.adapters.cpp = {
    type = 'executable',
    command = '/usr/bin/gdb', -- your local gdb path
    name = 'gdb'
}

dap.configurations.cpp = {
    {
        name = "(gdb) Launch",
        type = "cpp",
        request = "launch",
        program = vim.fn.getcwd() .. "/out/build/debug-x86/ecs-02-gui",
        cwd = vim.fn.getcwd() .. "/deb-package/opt/arex/ecs-02-gui",
        args = {},
        stopAtEntry = false,
        setupCommands = {
            {
                text = "-enable-pretty-printing",
                description = "Enable pretty-printing for gdb",
                ignoreFailures = true,
            },
            {
                text = "set breakpoint pending on",
                description = "Allow pending breakpoints",
                ignoreFailures = true,
            },
        },
    },
}

-- ================================
-- Sign Icons
-- ================================
vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

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

