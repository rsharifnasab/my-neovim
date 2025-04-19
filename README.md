# kickstart.nvim

## Introduction

### Install External Dependencies

Requirements:

- Basic utils: `git`, `make`, `unzip`, `gcc`, `nvim`, `ripgrep`
- Clipboard tool (xclip/xsel/win33yank or other depending on platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true

```bash
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim python-pynvim
```

### Install

```bash
git clone https://github.com/rsharifnasab/my-neovim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
current plugin status. Hit `q` to close the window.

Read through the `init.lua` file in your configuration folder for more
information about extending and exploring Neovim. That also includes
examples of adding popularly requested plugins.

### FAQ

- What should I do if I already have a pre-existing neovim configuration?
  - You should back it up and then delete all associated files.
  - This includes your existing init.lua and the neovim files in `~/.local`
    which can be deleted with `rm -rf ~/.local/share/nvim/`
- Can I keep my existing configuration in parallel to kickstart?
  - Yes! You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%25NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. For example, you can install the kickstart
    configuration in `~/.config/nvim-kickstart` and create an alias:

    ```bash
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    ```

    When you run Neovim using `nvim-kickstart` alias it will use the alternative
    config directory and the matching local directory
    `~/.local/share/nvim-kickstart`. You can apply this approach to any Neovim
    distribution that you would like to try out.
- What if I want to "uninstall" this configuration:
  - See [lazy.nvim uninstall](https://github.com/folke/lazy.nvim#-uninstalling) information

## Add new tools

- All available linters for nvim-lint are accessible [here](https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters)
- All available installable tools with Mason are `:Mason`
- All available lsps with lsp-config are
[here](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
or `h lspconfig-all`.
List of recommended lsp plugins is
[here](https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins)
- All available formatters for conform.nvim is [here](https://github.com/stevearc/conform.nvim/tree/master/lua/conform/formatters)

## TODO

- test editorconfig and undotree plugin
- check snippets like iferr in go
