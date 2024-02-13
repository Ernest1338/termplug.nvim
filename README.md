<h1><p align=center>Termplug.nvim</p></h1>
<h3><p align=center><sup>Simple neovim plugin to toggle a floating terminal window with customizable starting program</sup></p></h3>
<br \><br \>

![Screenshot 1](https://user-images.githubusercontent.com/45213563/222807806-4a4b9e21-bacb-42a3-ba69-2ed791ec765f.png)

## ⚙️ Features
- ~0ms load time
- <100 lines of Lua
- simple to setup and customize

This plugin exposes to the user only one function:
- toggle("optional: process_name") - opens (toggles) terminal window with given process (opens `bash` by default)

## 📦 Installation
- With [folke/lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{ "Ernest1338/termplug.nvim" }
```

- With [wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use "Ernest1338/termplug.nvim"
```

- With [echasnovski/mini.deps](https://github.com/echasnovski/mini.deps)
```lua
add("Ernest1338/termplug.nvim")
```

## 🚀 Usage
Firstly, call the `setup` function with optional config (see configuration options below):
```lua
require("termplug").setup()
```

In your init.lua, set the mapping to toggle a terminal window:
```lua
vim.keymap.set({ "n", "t" }, "<A-i>", "<cmd> Term <CR>")
```
If you want to toggle different process, eg. lazygit use:
```lua
vim.keymap.set({ "n", "t" }, "<C-g>", "<cmd> Term lazygit <CR>")
```

## 🔧 Configuration

There is only one configuration option: `size`.

It controlls how big will be the popup window. Takes values from `0.0` to `1.0` (defaults to 0.9).

**Set the size value to `1` for a full screen terminal popup.**

- For [folke/lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{ "Ernest1338/termplug.nvim", config = { size = 0.5 } },
```

- For [wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use {
    "Ernest1338/termplug.nvim",
    config = function()
        require("termplug").setup{ size = 0.5 }
    end
}
```

- For [echasnovski/mini.deps](https://github.com/echasnovski/mini.deps)
```lua
later(function()
    add("Ernest1338/termplug.nvim")
    require("termplug").setup({ size = 0.5 })
end)
```

## ⚡ Requirements
- Neovim >= **v0.7.0**

## ❔ Why

Because I wanted a simple plugin to toggle a popup terminal window with a mapping and every existing terminal plugins seem over complicated.

Combined with the ability to choose which process to execute, this plugin became not only a terminal plugin
but it can also toggle a popup window with any TUI application of your choosing.

For simplicity, it supports toggling only one of each process (one bash, one lazygit, ...) at a time.

