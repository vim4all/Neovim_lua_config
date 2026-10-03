# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a modular Neovim configuration written in Lua, using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

## Architecture

### Entry Point

`init.lua` sets the leader keys (`Space`) and loads three core modules in sequence:
1. `core/options.lua` — editor settings
2. `core/keymaps.lua` — global keybindings
3. `core/plugins.lua` — plugin manager bootstrap + plugin list

### Directory Layout

- `core/` — foundational config (options, keymaps, plugin list)
- `config/` — one file per plugin, each containing that plugin's `setup()` call and keymaps

### Adding or Modifying Plugins

1. Declare the plugin spec in `core/plugins.lua` (name, lazy-load triggers, `config` callback)
2. Create `config/<plugin-name>.lua` with the `setup()` call and any plugin-specific keymaps
3. In `core/plugins.lua`, point `config` at the new file: `config = function() require("config.<plugin-name>") end`

### Lazy Loading Conventions

Plugins use these triggers in `core/plugins.lua`:
- `event = "VeryLazy"` — general UI plugins
- `event = "BufReadPost"` / `BufReadPre` / `BufNewFile` — editor plugins and LSP
- `event = "InsertEnter"` / `CmdlineEnter` — completion
- `cmd = {...}` — load on command
- `keys = {...}` — load on keymap
- `ft = "tex"` — filetype-specific (VimTeX)
- `priority = 1000` — force-load first (Catppuccin theme)

### LSP Configuration

`config/lsp.lua` uses Neovim 0.10+ native LSP APIs (`vim.lsp.config()` / `vim.lsp.enable()`). Servers configured: `lua_ls`, `pyright`, `clangd`. LSP keymaps are set via an `LspAttach` autocmd, not globally.

### Keymap Layout

| Prefix | Domain |
|--------|--------|
| `<leader>f*` | Telescope find (files, grep, buffers, todo) |
| `<leader>g*` | Git (neogit, gitsigns operations) |
| `<leader>h*` | Git hunks (stage, undo, reset, preview, blame) |
| `<leader>l*` | LaTeX (VimTeX) |
| `<leader>rn` / `<leader>ca` | LSP rename / code action (also built-in `grn`/`gra`/`grr`/`gri`) |
| `<leader>cf` / `<leader>cd` / `<leader>ch` | Format / line diagnostics / clangd source↔header |
| `<A-,>` / `<A-.>` / `<A-1-9>` | Barbar buffer navigation |
| `<leader>d*`, `<leader>B` | DAP (`dc` continue, `ds`/`dw`/`de` step over/into/out, `db` breakpoint, `dC` run to cursor, `du` UI, `dh` inspect, `dq` terminate) — keys declared in `core/plugins.lua` |
| `F5` (per project) | Build & flash via project `.nvim.lua` (`exrc`) |
| `<C-h/j/k/l>` | Window navigation |
| `<leader>w/q` | Save / quit |
