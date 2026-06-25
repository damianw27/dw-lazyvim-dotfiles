# DW LazyVim dotfiles

Personal Neovim setup built on LazyVim.

## Required binaries

Install these to match current config.

### Arch Linux

```sh
sudo pacman -Syy --needed git ripgrep fd fzf wl-clipboard maven clang cmake dotnet-sdk lua-language-server zig eslint_d luacheck curl unzip tar gzip bash
```

Install Node tools:

```sh
sudo pacman -Syy --needed nodejs npm
sudo npm install -g corepack
corepack enable
pnpm add -g @vtsls/language-server eslint_d
```

Install .NET tool:

```sh
dotnet tool install -g roslyn-language-server --prerelease
```

Optional but recommended for C/C++ debugging:

```sh
sudo pacman -Syy --needed lldb
```

Optional but recommended for Lua local tooling:

```sh
luarocks install --local luacheck
```

### Windows 11

Native Windows packages:

```powershell
$packages = @(
  "Git.Git"
  "BurntSushi.Ripgrep.MSVC"
  "sharkdp.fd"
  "junegunn.fzf"
  "Microsoft.PowerShell"
  "Apache.Maven"
  "LLVM.LLVM"
  "Kitware.CMake"
  "Microsoft.DotNet.SDK.8"
  "Zig.Zig"
  "LuaLS.LuaLanguageServer"
  "7zip.7zip"
)

foreach ($package in $packages) {
  winget install --id $package -e
}
```

Install Node.js and global JS tools:

```powershell
winget install --id OpenJS.NodeJS.LTS -e
npm install -g corepack
corepack enable
pnpm add -g @vtsls/language-server eslint_d
```

Install Roslyn language server:

```powershell
dotnet tool install -g roslyn-language-server --prerelease
```

Optional but recommended for clipboard integration inside WSL:

```powershell
winget install --id equalsraf.win32yank -e
```

### Windows 11 with WSL

If you run Neovim inside WSL, install Linux-side tools there too.

Install Node with `nvm` inside WSL:

> On Windows 11, do this inside WSL.

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash
source "$HOME/.nvm/nvm.sh"
nvm install --lts
npm install -g corepack
corepack enable
pnpm add -g @vtsls/language-server eslint_d
```

Install Java with `sdkman` inside WSL:

> `sdkman` is WSL / UNIX only. Use it inside WSL on Windows 11.

```sh
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java
```

Install Roslyn language server inside WSL if Neovim runs there:

```sh
dotnet tool install -g roslyn-language-server --prerelease
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
- `NStefan002/screenkey.nvim`
- `seblyng/roslyn.nvim`
- `xzbdmw/colorful-menu.nvim`

## LazyVim extras

- `lazyvim.plugins.extras.editor.fzf`
- `lazyvim.plugins.extras.editor.aerial`
- `lazyvim.plugins.extras.editor.overseer`
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
- `lazyvim.plugins.extras.lang.zig`
- `lazyvim.plugins.extras.test.core`
- `lazyvim.plugins.extras.lang.yaml`
