# My Neovim config
derived from `kickstart.nvim`

## Introduction

### Install External Dependencies

Requirements:

- Basic utils: `git`, `make`, `unzip`, `gcc`, `nvim`, `ripgrep`
- Clipboard tool (xclip/xsel/win33yank or other depending on platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true

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

Also check `:Mason`, a package manager for external dependencies.

## TODO

-[ ] test editorconfig and undotree plugin
-[ ] check snippets like iferr in go
