# DW LazyVim dotfiles

Personal Neovim setup built on LazyVim.

## Required binaries

Install these to match current config:

Arch Linux:

```sh
sudo pacman -Syy --needed git ripgrep fd fzf wl-clipboard maven clang lua-language-server typescript-language-server zig eslint_d luacheck curl unzip tar gzip bash
```

Windows:

```powershell
$packages = @(
  "Git.Git"
  "BurntSushi.Ripgrep.MSVC"
  "sharkdp.fd"
  "junegunn.fzf"
  "Microsoft.PowerShell"
  "Apache.Maven"
  "LLVM.LLVM"
  "Zig.Zig"
  "LuaLS.LuaLanguageServer"
  "7zip.7zip"
)

foreach ($package in $packages) {
  winget install --id $package -e
}
```

Install Node with `nvm`:

> On Windows 11, do this inside WSL.

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash
source "$HOME/.nvm/nvm.sh"
nvm install --lts
```

Install Java with `sdkman`:

> `sdkman` is WSL / UNIX only. Use it inside WSL on Windows 11.

```sh
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java
```

Then install script-based tools:

```sh
corepack enable
pnpm add -g typescript-language-server eslint_d
luarocks install --local luacheck
```

Optional but useful:

- `delta` if you want colored terminal diffs with Git
- `win32yank.exe` on WSL when you want Windows clipboard bridging without OSC52

## `buf_manager` behavior

- Tracks last-viewed time per listed, normal file buffer.
- Excludes filetypes: `nvim_tree`, `neo_tree`, `fern`, `vista`, `lir`.
- On `BufEnter`, closes stale unmodified buffers not viewed for more than 300 seconds.
- Enforces a maximum of 6 tracked buffers by closing the oldest unmodified ones.

## Extra plugins and custom specs in `lua/plugins/custom.lua`

- `folke/snacks.nvim` (configured to show hidden files, including in explorer).
- `brenton-leighton/multiple-cursors.nvim`
- `lewis6991/async.nvim`
- `ThePrimeagen/refactoring.nvim`
- `tanvirtin/monokai.nvim`
- `dylon/vim-antlr`
- `rachartier/tiny-inline-diagnostic.nvim`
- `rafamadriz/friendly-snippets`
- `mbbill/undotree`
- `nvim-java/nvim-java`
- `xzbdmw/colorful-menu.nvim`

## LazyVim extras

- `lazyvim.plugins.extras.editor.fzf`
- `lazyvim.plugins.extras.coding.nvim-cmp`
- `lazyvim.plugins.extras.editor.refactoring`
- `lazyvim.plugins.extras.lang.angular`
- `lazyvim.plugins.extras.lang.typescript.biome`
- `lazyvim.plugins.extras.lang.clangd`
- `lazyvim.plugins.extras.lang.cmake`
- `lazyvim.plugins.extras.lang.docker`
- `lazyvim.plugins.extras.lang.git`
- `lazyvim.plugins.extras.lang.java`
- `lazyvim.plugins.extras.lang.json`
- `lazyvim.plugins.extras.lang.markdown`
- `lazyvim.plugins.extras.lang.typescript`
- `lazyvim.plugins.extras.lang.yaml`
