# VS Code Setup

VS Code is installed as a Flatpak (`com.visualstudio.code`). Auto-updates are disabled — updates are managed through Flatpak.

## Files

- `settings.json` — user settings
- `keybindings.json` — custom key bindings
- `extensions.txt` — list of extensions to install

## Extensions

Install all extensions from the list:

```bash
cat extensions.txt | xargs -L 1 flatpak run com.visualstudio.code --install-extension
```

| Extension | Purpose |
|-----------|---------|
| `asciidoctor.asciidoctor-vscode` | AsciiDoc preview and editing |
| `bierner.markdown-mermaid` | Mermaid diagram support in Markdown preview |
| `fstarlang.fstar-vscode-assistant` | F* language support |
| `github.vscode-github-actions` | GitHub Actions workflow editing |
| `golang.go` | Go language support |
| `jacobdufault.fuzzy-search` | Fuzzy search within the active editor |
| `marp-team.marp-vscode` | Markdown presentation slides (Marp) |
| `ms-azuretools.vscode-containers` | Container management (Docker/Podman) |
| `ms-python.python` | Python language support (includes Pylance, debugpy) |
| `ms-vscode-remote.vscode-remote-extensionpack` | Remote development (SSH, Containers) |
| `ms-vscode.makefile-tools` | Makefile support |
| `ocamllabs.ocaml-platform` | OCaml language support |
| `rust-lang.rust-analyzer` | Rust language support |
| `streetsidesoftware.code-spell-checker` | Spell checking |
| `streetsidesoftware.code-spell-checker-portuguese-brazilian` | Brazilian Portuguese dictionary for spell checker |
| `streetsidesoftware.code-spell-checker-spanish` | Spanish dictionary for spell checker |
| `vscodevim.vim` | Vim keybindings |
| `yzhang.markdown-all-in-one` | Markdown editing shortcuts and TOC |

## Settings highlights

- **Font**: JetBrains Mono with ligatures
- **Vim mode**: enabled with system clipboard, relative line numbers, highlighted yank, hlsearch, and visual star. Common VS Code keybindings (`Ctrl+A/C/F/K/P/T/V/X`) are passed through to VS Code instead of Vim.
- **Formatting**: format on save, trim trailing whitespace, render boundary whitespace
- **Containers**: uses `podman-remote` as the Docker path, Wayland socket mounting disabled
- **Python**: Pylance language server with basic type checking
- **OCaml**: extended hover and syntax documentation enabled
- **Terminal**: `LD_PRELOAD` is unset to avoid issues with preloaded libraries in the integrated terminal

## Keybindings

| Key | Action |
|-----|--------|
| `Ctrl+Shift+C` | Toggle Markdown code block |
| `Ctrl+G` | Fuzzy search in active editor |
| `Ctrl+Shift+7` | Toggle line comment |
| `Ctrl+I` | Cursor agent mode |
| `Ctrl+B` | Unbound from Vim (uses VS Code sidebar toggle) |
| `Ctrl+W` | Unbound from Vim (uses VS Code tab close) |
