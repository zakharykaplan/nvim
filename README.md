# nvim

<p align="center">
  <img width="100" height="100" src="./docs/neovim-logo.svg"/>
</p>

<p align="center">
  <q>
    We become what we behold. We shape our tools, and thereafter our tools shape
    us.
  </q>
  &mdash;
  <i>
    Marshall McLuhan
  </i>
</p>

---

Welcome to my (awesome) [Neovim][neovim] setup! Here you'll find the
configuration for the editor that I use as my daily driver.

## Installation

Installation is as simple as cloning this repository into your Neovim home:

```shell
git clone https://git.zakhary.dev/nvim ~/.config/nvim
```

Afterwards, install plugins using [packer.nvim][packer]:

```vim
PackerSync
```

... and that's it! You should now be ready to hack away.

### Updating

To keep up-to-date, regularly `git pull` this repository. Note that after a
pull, plugins may need to be synced.

## Usage

### Plugins

Plugins are managed using [packer.nvim][packer]. To update a plugin, use:

```vim
PackerUpdate <plugin>
```

Or, to update all plugins:

```vim
PackerUpdate
```

### LSP

Language servers can be installed using [mason.nvim][mason]. For more
information, see mason.nvim's [help][mason-help].

In general, LSP should automatically launch for installed servers upon opening a
file. Neovim may need to be restarted after install for the first time.

<!-- Reference-style links -->
[mason]:      https://github.com/williamboman/mason.nvim
[mason-help]: https://github.com/williamboman/mason.nvim/blob/main/doc/mason.txt
[neovim]:     https://neovim.io
[packer]:     https://github.com/wbthomason/packer.nvim
