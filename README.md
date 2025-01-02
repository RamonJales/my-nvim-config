# my-nvim-config

My OS is: Manjaro. So if you use a windows or something else, remember to adapt.

In `~/.config/nvim/` directory put `init.lua` file and `lua/ramon` directory you downloded from this repository. Of course, you must, if you want, change de `lua/ramon` for `lua/"your-name"`.
The plugins will be installed automatically, if this not happen, go to `Lazy` window and install the plugins.

If telescope does not works, so install `Ripgrep`.

Install a clipboard provider, like `xclip` or `xsel`.

Install `lazygit` with your package.

The file `init.lua` in root directory calls `core` and `lazy` files.

The file `init.lua` from core directory calls the `keymaps` nad `options` file. The `keymaps` file contains the shortcuts and their descriptions from these. And the `options` has general options
from nvim configurations.

In `plugins` we have the all plugins the you want in your nvim. The `init.lua` file from `/plugins` directory is for plugins tha dont need specific configurations. The separation struct is for each file in plugins has your own specific configuration.

For more information: https://www.josean.com/posts/how-to-setup-neovim-2024

### My shortcuts

- tmux:
  - You can navigate in tmux windows with `Ctrl + hjkl`.
- telescope:
  - You can navigate in telescope window with `Ctrl + hjkl`.
- auto-session:
  - You can save the session with `<Space>ws`
  - You can restore the session with `<Space>wr`
