# DW LazyVim dotfiles

Personal Neovim setup built on LazyVim.

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
