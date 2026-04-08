# Helix Configuration

Helix editor setup, migrated from Neovim. Uses built-in features for LSP, treesitter, completion, and git gutter — no plugins needed.

## Structure

```
helix/
├── config.toml                # Editor settings and key mappings
├── languages.toml             # Language servers and per-language settings
└── themes/
    └── sonokai-custom.toml    # Custom theme (sonokai + custom background)
```

## Theme

Inherits from `sonokai` with custom overrides:
- Background: `#263238`
- Cursorline: `#2E3C43`

## LSP

Language servers are configured in `languages.toml`. Install them manually:

| Server | Language | Install |
|--------|----------|---------|
| `ocamllsp` | OCaml | `opam install ocaml-lsp-server` |
| `gopls` | Go | `go install golang.org/x/tools/gopls@latest` |

### OCaml LSP features

- Inlay hints (let bindings, pattern variables, function params)
- Extended hover (richer type info and docs)
- Dune diagnostics
- Auto-format on save

Check language support with `hx --health ocaml` or `hx --health go`.

## Key mappings

Custom bindings are added on top of Helix defaults — nothing is overridden.

### Custom shortcuts

| Key | Mode | Action |
|-----|------|--------|
| `Ctrl-s` | normal/insert | Save |
| `Alt-x` | normal | Quit |
| `K` | normal | Hover (type info) |
| `Ctrl-/` | normal/insert/select | Toggle comment |
| `Alt-Up/Down` | normal/insert/select | Move line(s) |
| `Tab/Shift-Tab` | normal/select | Indent/dedent |
| `Alt-Left/Right` | normal | Dedent/indent |
| `Alt-Tab` | normal | Next buffer |
| `Shift-Alt-Tab` | normal | Previous buffer |
| `Ctrl-p` | normal | File picker |
| `Ctrl-f` | normal | Global search |

### Useful Helix defaults

| Key | Action |
|-----|--------|
| `Space-f` | File picker |
| `Space-/` | Global search |
| `Space-k` | Hover docs |
| `gd` | Go to definition |
| `gr` | Go to references |
| `Space-r` | Rename symbol |
| `Space-a` | Code actions |
| `gc` | Toggle comment (select mode) |
| `gcc` | Comment line |
| `:lsp-restart` | Restart language server |

## Known limitations

- **CodeLens not supported** — Helix doesn't display LSP CodeLens (e.g. type signatures above functions). The `codelens` setting is sent to `ocamllsp` but Helix has no way to render it. See [helix-editor/helix#5063](https://github.com/helix-editor/helix/pull/5063) for progress.
- **`Ctrl-/` for comments not working** — The Flatpak Neovim doesn't support the Kitty keyboard protocol, so enabling `enable_kitty_keyboard = true` in WezTerm (required for `Ctrl-/` in Helix) breaks `Ctrl-/` in Neovim. Use `Ctrl-c` instead (Helix default for toggle comments). Workaround: add `enable_kitty_keyboard = true` to `wezterm.lua` if you don't need `Ctrl-/` in Neovim.
- **No REPL integration** — Helix has no plugin system, so there's no equivalent to iron.nvim. Workaround: use WezTerm split panes or tmux/zellij to run a REPL alongside Helix. Selections can be piped with `:pipe-to`.

## Terminal requirements

Requires WezTerm with `enable_kitty_keyboard = true` for `Ctrl-/` to work. This enables the Kitty keyboard protocol which properly sends modifier+key combinations.

## Built-in features (no plugins needed)

Helix provides these out of the box — no configuration required:

- Treesitter syntax highlighting and indentation
- LSP completion, hover, diagnostics, code actions
- Document highlight (symbol references)
- Git gutter signs
- Auto-pairs (brackets, quotes)
- File picker with fuzzy search
- Surround (select + `ms`)
- Multiple cursors
