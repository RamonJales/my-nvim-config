# my-nvim-config

My OS is: Manjaro. So if you use a windows or something else, remember to adapt.

A personal Neovim configuration built with Lua, focusing on performance and modularity.

OS Note: This configuration was designed on Manjaro/Pop!_OS (Linux). If you are using macOS or Windows (via WSL), ensure you adapt the external dependencies accordingly.

## Prerequisites
Before installing, ensure you have the following tools installed on your system

```Bash
sudo apt install neovim ripgrep xclip lazygit build-essential
```

Note: A Nerd Font is recommended for icons to render correctly.

## Installation

1. Standard Installation

    This will install the configuration keeping the original namespace (ramon).
  
    1.1 Clone the repository:
    
    ```Bash
    git clone https://github.com/RamonJales/my-nvim-config.git ~/.config/nvim
    ```
    1.2 Open Neovim.


2. Custom Installation (Rename to "your-name")

    If you want to personalize the configuration structure (change lua/ramon to lua/yourname), follow these steps after cloning:
    
    2.1 Enter the config directory:
    
    ```Bash
    cd ~/.config/nvim
    ```
    
    2.2 Choose your new namespace name (Replace your_name with your name):
    
    ```Bash
    export NEW_NAME="your_name"
    ```
    
    2.3 Rename the directory:
    
    ```Bash
    mv lua/ramon lua/$NEW_NAME
    ```
    
    2.4 Update all references in files: This command will search for "ramon" in all `.lua` files and replace it with your new name automatically:
    
    ```Bash
    grep -rl "ramon" . | xargs sed -i "s/ramon/$NEW_NAME/g"
    ```
    
    2.5 Start Neovim.

## Coments

- If telescope does not works, so install `Ripgrep`.

- Install a clipboard provider, like `xclip` or `xsel`.

- Install `lazygit` with your package.

The file `init.lua` in root directory calls `core` and `lazy` files.

The file `init.lua` from core directory calls the `keymaps` nad `options` file. The `keymaps` file contains the shortcuts and their descriptions from these. And the `options` has general options from nvim configurations.

In `plugins` we have the all plugins the you want in your nvim. The `init.lua` file from `/plugins` directory is for plugins tha dont need specific configurations. The separation struct is for each file in plugins has your own specific configuration.

## Project Structure

- `init.lua` (Root): Bootstraps the configuration by calling the core modules and the Lazy plugin manager.

- `lua/ramon/core/`:

   - `init.lua`: Orchestrates the core settings.

   - `options.lua`: General Neovim settings (line numbers, tabs, etc).

   - `keymaps.lua`: Native keybindings and descriptions.

- `lua/ramon/plugins/`:

   - `init.lua`: Contains plugins that don't require extensive configuration.

   - `[plugin-name].lua`: Individual configuration files for complex plugins (e.g., lsp, treesitter, telescope).

For more information: https://www.josean.com/posts/how-to-setup-neovim-2024

## My shortcuts

#### tmux:
  - You can navigate in tmux windows with `Ctrl + hjkl`.
#### telescope:
  - You can navigate in telescope window with `Ctrl + hjkl`.
#### auto-session:
  - You can save the session with `<Space>ws`
  - You can restore the session with `<Space>wr`

#### Trouble

A modern interface to visualize diagnostic lists (LSP), references, quickfixes, and TODOs.

Keymaps

| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `<leader>xw` | **Workspace Diagnostics** | Shows errors/warnings for the **entire project**. |
| `<leader>xd` | **Document Diagnostics** | Shows errors/warnings for the **current file** only. |
| `<leader>xt` | **Todo List** | Lists all `TODO`, `FIX`, `HACK` items found in the project. |
| `<leader>xq` | **Quickfix List** | Opens the quickfix list (e.g., compilation results). |
| `<leader>xl` | **Location List** | Opens the location list (window specific). |

## How to uninstall

1. User Configuration (Your Lua scripts):

```Bash
rm -rf ~/.config/nvim
```

2. Plugin Data (Where Lazy downloads code for Telescope, Treesitter, etc.):

```Bash
rm -rf ~/.local/share/nvim
```

3. State and History (Logs, undo history, swap files):

```Bash
rm -rf ~/.local/state/nvim
```
4. Cache (Temporary files):

```Bash
rm -rf ~/.cache/nvim
```

5. Location of downloaded plugins (Lazy, Mason, etc.) and Logs/Undo history:

```Bash
rm -rf ~/.local/share/nvim ~/.local/state/nvim
```
