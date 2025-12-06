# 🌙 Neovim Lua Configuration

A modular, plugin-focused Neovim configuration written fully in **Lua**.  This
setup provides modern UI enhancements, LSP support, Git integration,
Treesitter, debugging, file tree navigation, and more. This README describes
the **exact structure and plugins included** in this repository.

---

## 📁 Directory Structure

```C
nvim/
├── .gitignore
├── init.lua
├── core/
│ ├── keymaps.lua
│ ├── options.lua
│ └── plugins.lua
└── config/
├── catppuccin.lua
├── dap.lua
├── gitsigns.lua
├── indent.lua
├── lualine.lua
├── neogit.lua
├── nvim-tree.lua
├── telescope.lua
├── treesitter.lua
├── vimtex.lua
└── whichkey.lua
```

### **`init.lua`**
Main entry point — loads core modules and plugin configs.

### **`core/`**
Basic editor configuration:
- **options.lua** — Neovim settings (indentation, UI, behavior)
- **keymaps.lua** — all keybindings
- **plugins.lua** — lazy.nvim plugin list + setup

### **`config/`**
Each plugin has its own standalone configuration module:
- **catppuccin.lua** — Catppuccin theme setup  
- **dap.lua** — Debug Adapter Protocol configuration for debugging  
- **gitsigns.lua** — Git change indicators  
- **indent.lua** — Indentation guides  
- **lualine.lua** — Statusline (lualine)  
- **neogit.lua** — Neogit UI for Git  
- **nvim-tree.lua** — File explorer  
- **telescope.lua** — Telescope fuzzy finder  
- **treesitter.lua** — Treesitter syntax + highlighting  
- **vimtex.lua** — LaTeX support (VimTeX)  
- **whichkey.lua** — Keymap helper popup  

---

## 🔌 Included Plugins

Below is a description of all plugins used:

### 🎨 **UI / Appearance**
- **Catppuccin** — modern theme  
- **Lualine** — highly customizable statusline  

### 🔍 **Navigation / Fuzzy Finding**
- **Telescope.nvim** — fuzzy finder for files, commands, LSP, etc.  
- **nvim-tree.lua** — sidebar file explorer  

### ✍️ **Editor Enhancements**
- **Treesitter** — syntax tree parsing, highlighting, folding  
- **Indent-blankline** — indentation guides  
- **Which-key** — displays available keybindings  

### 🧠 **LSP / Programming**
- [ ] TODO

### 🐞 **Debugging**
- **nvim-dap** — DAP debugging
- **nvim-dap UI addons**

### 🧵 **Git Integration**
- **Gitsigns.nvim** — diff signs and inline git info
- **Neogit** — Magit-like Git UI  

### 📚 **LaTeX**
- **VimTeX** — full LaTeX editing environment  

---

## 🛠️ Customization

Add plugins → core/plugins.lua

Modify options → core/options.lua

Change keymaps → core/keymaps.lua

Edit individual plugin settings → config/*.lua

The design is fully modular — each plugin lives in its own file.

## 🤝 Contributing

Pull requests and suggestions are welcome.
This config aims to stay modular, clean, and easy to extend.
