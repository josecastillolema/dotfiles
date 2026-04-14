# Neovim Configuration

Neovim 0.12+ (Flatpak: `io.neovim.nvim`) configuration using native features wherever possible.

## Structure

```
vim/
├── vimrc                  # Entry point, sources all config files
└── vim/
    ├── plugins.lua        # Plugin manager (vim.pack)
    ├── lsp.lua            # LSP servers, completion, formatting, inlay hints
    ├── keys.vim           # Key mappings
    ├── ui.vim             # Colors, highlights, cursor, colorcolumn
    ├── bufferline.lua     # Buffer tab bar config
    ├── nvimtree.lua       # File explorer config
    ├── telescope.lua      # Fuzzy finder config
    ├── statusline.lua     # Lualine status bar config
    ├── scrollbar.lua      # Scrollbar config
    ├── repl.lua           # Iron.nvim REPL config
    ├── mouse.vim          # Mouse settings
    ├── search.vim         # Search settings
    └── ftplugin/          # Filetype-specific settings
```

## Plugin Manager

Uses Neovim's built-in `vim.pack` (added in 0.12). No external plugin manager needed.

### Add a plugin

Add the GitHub URL to the list in `plugins.lua`:

```lua
vim.pack.add({
  -- existing plugins...
  "https://github.com/author/plugin-name",
})
```

Restart Neovim and it will be cloned automatically.

### Update plugins

Run inside Neovim:

```vim
:lua vim.pack.update()
```

### Remove a plugin

1. Remove the URL from `plugins.lua`
2. Run inside Neovim:

```vim
:lua vim.pack.del("plugin-name")
```

## LSP

Uses Neovim's **native LSP client** (`vim.lsp`) — no `nvim-lspconfig` or `mason` needed.

### Configured servers

| Server | Language | Install |
|--------|----------|---------|
| `ocamllsp` | OCaml | `opam install ocaml-lsp-server` |
| `gopls` | Go | `go install golang.org/x/tools/gopls@latest` |
| `ty` | Python | `pip install -U ty` |
| `rust-analyzer` | Rust | `rustup component add rust-analyzer` |

### Features enabled on LSP attach

- **Auto-completion** — triggers automatically, use `Ctrl-Y` to accept
- **Format on save** — via `textDocument/formatting`
- **Inlay hints** — inline type annotations
- **CodeLens** — type signatures above functions (refreshed on enter/insert leave)
- **Document highlight** — highlights references of symbol under cursor (500ms delay)
- **Diagnostics** — shown as virtual lines
- **Hover** — press `K` for type info and docs

### OCaml-specific settings

- `codelens` — type signatures above definitions
- `extendedHover` — richer hover info with docs
- `duneDiagnostics` — diagnostics from dune
- `inlayHints` — hints for let bindings, pattern variables, function params

OCaml projects need a `dune-project` and `dune` file for full LSP support. Run `dune build -w` for best results.

## Native features replacing plugins

Several previously used plugins were replaced by Neovim 0.12 built-in features:

| Removed plugin | Replaced by |
|----------------|-------------|
| `nvim-lspconfig` | `vim.lsp.config` / `vim.lsp.enable` |
| `nvim-cmp` | `vim.lsp.completion.enable` |
| `nerdcommenter` | Built-in `gc` / `gcc` (also mapped to `Ctrl-/`) |
| `vim-illuminate` | `vim.lsp.buf.document_highlight` |
| `neoformat` | `vim.lsp.buf.format` on save |
| `vim-sensible` | Neovim defaults |
| `mason.nvim` | Manual server installation |
| `LuaSnip` | Not needed for LSP completion |
| `vim-plug` | `vim.pack` |

## Key mappings

Leader key: `Space`

### General

| Key | Mode | Action |
|-----|------|--------|
| `Ctrl-/` | n/v/i | Toggle comment |
| `Ctrl-s` | i | Save |
| `Alt-x` | n/v/i | Quit |
| `Alt-Up/Down` | n/v/i | Move line(s) up/down |
| `Alt-Tab` | n | Next buffer |
| `K` | n | Hover (type info) |
| `Ctrl-.` | n | Code actions |

### Find (`<leader>f`)

| Key | Action |
|-----|--------|
| `<leader>ff` | File browser (Telescope) |
| `<leader>fg` | Live grep (Telescope) |
| `<leader>fb` | Buffers (Telescope) |
| `<leader>fh` | Help tags (Telescope) |
| `<leader>fd` | Diagnostics (Telescope) |
| `<leader>fc` | Commands (Telescope) |
| `Ctrl-p` | File browser (Telescope) |
| `Ctrl-f` | Live grep (Telescope) |

### LSP (`<leader>l`)

| Key | Action |
|-----|--------|
| `<leader>lr` | Rename |
| `<leader>la` | Code action |
| `<leader>lf` | Format |
| `<leader>ld` | Go to definition |
| `<leader>ls` | References |
| `<leader>lh` | Hover |
| `<leader>li` | Implementation |
| `<leader>ll` | CodeLens run |
| `<leader>lt` | Toggle diagnostics |

### Git (`<leader>g`)

| Key | Action |
|-----|--------|
| `<leader>gs` | Stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gu` | Undo stage hunk |
| `<leader>gp` | Preview hunk |
| `<leader>gb` | Blame line |
| `<leader>gd` | Diff |
| `<leader>gn` | Next hunk |
| `<leader>gN` | Prev hunk |

### REPL (`<leader>r`)

| Key | Action |
|-----|--------|
| `<leader>r` | Open REPL |
| `<leader>rr` | Restart |
| `<leader>rf` | Send file |
| `<leader>rl` | Send line |
| `<leader>ru` | Send until cursor |
| `<leader>rs` | Send mark |
| `<leader>rm` | Mark motion/visual |
| `<leader>rd` | Remove mark |
| `<leader>rc` | Clear |
| `<leader>ri` | Interrupt |
| `<leader>rq` | Exit |
| `<leader>rh` | Hide |
| `Alt-Enter` | Send motion/visual |

### Terminal

| Key | Action |
|-----|--------|
| `<leader>T` | Toggle terminal in bottom split (15% height) |

### Tree

| Key | Action |
|-----|--------|
| `<leader>t` | Toggle file tree |
| `Ctrl-t` | Toggle file tree |

## Plugins

| Plugin | Description |
|--------|-------------|
| **bufferline.nvim** | Buffer tab bar |
| **nvim-scrollview** | Scrollbar |
| **onedark.vim** | Color scheme |
| **gitsigns.nvim** | Git signs and hunk actions |
| **indent-blankline.nvim** | Indentation guides |
| **nvim-tree.lua** | File explorer |
| **plenary.nvim** | Lua utility library (dependency) |
| **lualine.nvim** | Status bar |
| **telescope.nvim** | Fuzzy finder |
| **telescope-file-browser.nvim** | File browser for Telescope |
| **nvim-web-devicons** | File type icons |
| **quickfixdd** | Delete quickfix entries with `dd` |
| **iron.nvim** | REPL integration |
| **nvim-autopairs** | Auto-close brackets and quotes |
| **which-key.nvim** | Shows available keybindings after pressing leader |
| **wilder.nvim** | Fuzzy popup menu for `:`, `/`, and `?` |

## Flatpak notes

The Neovim Flatpak has a custom PATH configured via:

```sh
flatpak override --user --show io.neovim.nvim
```

Tools like `gopls`, `ocamllsp`, and `rg` are accessible from `~/bin` and opam/go paths added to the override.
