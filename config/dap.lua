local dap_ok, dap = pcall(require, "dap")
if not dap_ok then return end

-- GDB >= 14 is required for --interpreter=dap (/usr/bin/gdb is 12.1)
local GDB = "/usr/local/bin/gdb"

-- ================================
-- Python Adapter
-- ================================
local function python_path()
    local venv = os.getenv("VIRTUAL_ENV")
    if venv then return venv .. "/bin/python" end
    for _, dir in ipairs({ ".venv", "venv" }) do
        local p = vim.fn.getcwd() .. "/" .. dir .. "/bin/python"
        if vim.fn.executable(p) == 1 then return p end
    end
    return "python3"
end

dap.adapters.python = {
    type = "executable",
    command = "python3",
    args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        console = "integratedTerminal",
        pythonPath = python_path,
    },
    {
        type = "python",
        request = "launch",
        name = "Launch module",
        module = "${fileBasenameNoExtension}",
        console = "integratedTerminal",
        pythonPath = python_path,
    },
}

-- ================================
-- C++ Adapter (host GDB, native DAP mode)
-- ================================
dap.adapters.gdb = {
    type = "executable",
    command = GDB,
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}

local function split_args(prompt)
    return vim.split(vim.fn.input(prompt), " ", { trimempty = true })
end

-- EVerest: out-of-tree build in ~/wrk_dir/build (see build/run-scripts/*.sh)
local everest_src  = vim.fn.expand("~/wrk_dir/EVerest")
local everest_dist = vim.fn.expand("~/wrk_dir/build/dist")

dap.configurations.cpp = {
    {
        name = "Launch executable",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/build/", "file")
        end,
        args = function() return split_args("Args: ") end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
    {
        -- EVerest modules run as child processes of `manager`: start it
        -- normally (or via the config below) and attach to the module here.
        name = "Attach to process",
        type = "gdb",
        request = "attach",
        pid = function() return require("dap.utils").pick_process() end,
        cwd = "${workspaceFolder}",
    },
    {
        name = "EVerest manager",
        type = "gdb",
        request = "launch",
        program = everest_dist .. "/bin/manager",
        args = function()
            local conf = vim.fn.input("Config: ", everest_src .. "/config/", "file")
            return { "--prefix", everest_dist, "--conf", conf }
        end,
        env = { LD_LIBRARY_PATH = everest_dist .. "/lib" },
        cwd = everest_dist,
    },
}

-- ================================
-- STM32 / Cortex-M Adapter (GDB + OpenOCD, via ~/.local/bin/gdb-openocd)
-- ================================
dap.adapters.cortex_m = function(callback, config)
    callback({
        type = "executable",
        command = vim.fn.expand("~/.local/bin/gdb-openocd"),
        args = { config.program },
        options = { initialize_timeout_sec = 30 },
    })
end

local function pick_elf()
    local candidates = {}
    -- ESP-IDF layout: build/<project>.elf directly (no Debug/Release subdir).
    vim.list_extend(candidates, vim.fn.glob(vim.fn.getcwd() .. "/build/*.elf", false, true))
    for _, build_type in ipairs({ "Debug", "Release" }) do
        local matches = vim.fn.glob(vim.fn.getcwd() .. "/build/" .. build_type .. "/*.elf", false, true)
        vim.list_extend(candidates, matches)
    end
    if #candidates == 0 then
        return vim.fn.input("ELF: ", vim.fn.getcwd() .. "/build/Debug/", "file")
    elseif #candidates == 1 then
        return candidates[1]
    end
    local labels = { "Select ELF:" }
    for i, f in ipairs(candidates) do
        labels[#labels + 1] = i .. ") " .. vim.fn.fnamemodify(f, ":~:.")
    end
    local idx = vim.fn.inputlist(labels)
    return (idx >= 1 and idx <= #candidates) and candidates[idx] or candidates[1]
end

dap.configurations.c = {
    {
        name = "STM32 Debug (OpenOCD)",
        type = "cortex_m",
        request = "attach",
        target = "localhost:3333",
        program = pick_elf,
        cwd = "${workspaceFolder}",
    },
}
dap.configurations.asm = dap.configurations.c

-- ================================
-- TI C2000 / C28x Adapter (TI debug server, via the project's tools/c2000-dap)
-- ================================
-- GDB/OpenOCD can't debug a C28x. A project that ships tools/c2000-dap (a DAP server on
-- TI's Python scripting API, e.g. DCR_C2000_Converter) gets these configurations; the
-- first connect takes ~40 s while the debug server configures the target.
local c2000_dap = vim.fn.getcwd() .. "/tools/c2000-dap"
if vim.fn.executable(c2000_dap) == 1 then
    dap.adapters.c2000 = {
        type = "executable",
        command = c2000_dap,
        options = { initialize_timeout_sec = 60 },
    }

    local function pick_out()
        local outs = vim.fn.glob(vim.fn.getcwd() .. "/build/*/*.out", false, true)
        if #outs == 1 then return outs[1] end
        local labels = { "Select .out:" }
        for i, f in ipairs(outs) do labels[#labels + 1] = i .. ") " .. vim.fn.fnamemodify(f, ":~:.") end
        local idx = vim.fn.inputlist(labels)
        return outs[idx] or vim.fn.input(".out: ", vim.fn.getcwd() .. "/build/Debug/", "file")
    end
    local function pick_ccxml()
        local files = vim.fn.glob(vim.fn.getcwd() .. "/targetConfigs/*.ccxml", false, true)
        return files[1] or vim.fn.input("ccxml: ", vim.fn.getcwd() .. "/", "file")
    end

    local c2000 = {
        {
            name = "C2000: flash and debug (run to main)",
            type = "c2000",
            request = "launch",
            program = pick_out,
            ccxml = pick_ccxml,
            core = "C28xx_CPU1",
            cwd = "${workspaceFolder}",
        },
        {
            name = "C2000: attach (symbols only, halt)",
            type = "c2000",
            request = "attach",
            program = pick_out,
            ccxml = pick_ccxml,
            core = "C28xx_CPU1",
            cwd = "${workspaceFolder}",
        },
    }
    -- In a C2000 project these come first, ahead of the Cortex-M entries.
    dap.configurations.c = vim.list_extend(vim.deepcopy(c2000), dap.configurations.c)
    dap.configurations.asm = dap.configurations.c
end

-- ================================
-- Sign Icons
-- ================================
vim.fn.sign_define("DapBreakpoint",          { text = "●", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DapBreakpointRejected",  { text = "○", texthl = "DiagnosticHint" })
vim.fn.sign_define("DapStopped",             { text = "▶", texthl = "DiagnosticOk", linehl = "Visual" })

-- ================================
-- DAP UI + virtual text
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

local vt_ok, vt = pcall(require, "nvim-dap-virtual-text")
if vt_ok then vt.setup() end

-- Keymaps are declared in core/plugins.lua (`keys`) so any of them lazy-loads DAP.
