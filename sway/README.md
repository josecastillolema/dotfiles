# Sway Configuration

Custom sway configuration for Fedora Atomic Sway. Config files live in `config.d/` and are included by the main sway config.

## Structure

```
sway/
├── 90-bar.conf                        # Waybar as the status bar
├── config.d/
│   ├── 60-bindings-screenshot.conf    # Screenshot keybindings (grimshot)
│   ├── autostart.conf                 # Programs run at sway startup
│   ├── bindgestures.conf              # Touchpad gestures
│   ├── bindkeys.conf                  # Keyboard shortcuts (apps, workspaces, etc.)
│   ├── bindsym.conf                   # Mouse button bindings
│   ├── input.conf                     # Keyboard layout and touchpad settings
│   ├── output.conf                    # Monitor configuration and scaling
│   ├── theme.conf                     # Colors, borders, gaps, font
│   ├── windows.conf                   # Floating rules and window assignments
│   └── workspaces.conf                # Workspace naming, assignment, and output mapping
├── scripts/
│   ├── lid-close.sh                   # Lid close handler (disable display, suspend on battery)
│   ├── run.sh                         # Smart app launcher (focus or launch)
│   └── vpn.sh                         # Red Hat VPN toggle
└── test-config                        # Minimal config for testing (sway -c test-config)
```

## Workspace Layout

| Workspace | Name | Apps |
|-----------|------|------|
| 0 | `$wsa` | Thunar, Nautilus |
| 1 | `$wsm` | Ferdium, Zen |
| 2 | `$wsb` | Firefox, Chrome, Claude |
| 3 | `$wst` | WezTerm |
| 4 | `$wsd` | VS Code, Cursor, Emacs, Gvim |
| 8 | — | Transmission |
| 9 | — | Laptop display only |

Workspaces 0–8 are assigned to external monitors; workspace 9 is pinned to the laptop display.

## Key Bindings

`$mod` is the Super (Windows) key.

### Applications

| Binding | Action |
|---------|--------|
| `$mod+Return` | WezTerm (smart launch) |
| `$mod+Shift+Return` | Foot terminal |
| `$mod+c` | Firefox (smart launch) |
| `$mod+n` | Thunar file manager |
| `$mod+Space` | Rofi app launcher (toggle) |
| `$mod+l` | Rofi file search (`fd` + `xdg-open`) |
| `$mod+p` | OTP code to clipboard |
| `$mod+Shift+v` | VPN toggle |
| `$mod+Shift+p` | Color picker (hex to clipboard) |
| `$mod+Shift+h` | Suspend |
| `$mod+Escape` | Lock screen |
| `$mod+Shift+e` | Exit/suspend/reboot/poweroff mode (ESC to cancel) |
| `$mod+x` | Kill focused window |

### Workspaces

| Binding | Action |
|---------|--------|
| `$mod+0..9` | Switch to workspace |
| `$mod+Shift+0..9` | Move container to workspace and follow |
| `$mod+Ctrl+Right/Left` | Next/previous workspace |
| `$mod+Alt+Right/Left` | Next/previous workspace |
| `Ctrl+Alt+Right/Left` | Next/previous workspace |
| `$mod+>` / `$mod+<` | Move container to next/prev workspace and follow |
| `Shift+Ctrl+Alt+Right/Left` | Move workspace to another output |
| `$mod+Tab` | Focus right |
| `$mod+Shift+Tab` | Focus left |

### Screenshots (grimshot)

| Binding | Action |
|---------|--------|
| `Print` | Save current output |
| `Alt+Print` | Save active window |
| `Ctrl+Print` | Select and save area |

### Menu Key Combos

| Binding | Action |
|---------|--------|
| `Menu+Up/Down` | Page Up / Page Down |
| `Menu+Left/Right` | Home / End |
| `Menu+Backspace` | Delete |

## Mouse Bindings

| Binding | Action |
|---------|--------|
| Button 8 (back) | Focus previous window |
| Button 9 (forward) | Focus next window |
| `$mod+Scroll Up/Down` | Previous/next workspace |
| `$mod+Middle Click` | Kill window |
| `$mod+Shift+Middle Click` | Move to scratchpad |
| `$mod+Button 8/9` | Show scratchpad |

## Touchpad Gestures

| Gesture | Action |
|---------|--------|
| 3-finger swipe left/right | Focus previous/next window |
| 4-finger swipe left/right | Previous/next workspace |
| 3-finger swipe up/down | Toggle floating |
| 4-finger swipe up | Open app menu |
| 4-finger swipe down | Close Rofi |
| Pinch inward + direction | Move container |

## Input

- Keyboard layout: **Spanish (`es`)**
- `altwin:menu_win` — Menu key acts as Win/Super
- Touchpad: tap enabled, disable-while-typing off, middle emulation disabled

## Theme

- Font: JetBrains Mono Bold 13
- Inner gaps: 8px
- Borders: hidden by default (`default_border none`, `smart_borders on`)
- Color scheme: dark grey tones (`#2b303b` background, `#47515b` borders)

## Autostart

On sway startup (`autostart.conf`):
- Starts `sway-xdg-autostart.target` so XDG autostart services (blueman, nm-applet, Dropbox, etc.) come up cleanly
- Sets X11 DPI to 130 (`xrdb`)
- Cleans up `*.tmp` and `*.swp` from home
- Empties trash older than 5 days (`trash-empty` via toolbox)
- Prunes unused Podman containers and volumes

On sway exit (`bindkeys.conf`, `$mod+Shift+e` → `e`, and swaync power button):
- Stops `graphical-session.target` before terminating the session, which cascades to all `PartOf` services (blueman, nm-applet, Dropbox, xdg-desktop-portal, etc.) so they stop cleanly instead of crashing with a broken pipe
- The swaync logoff button uses `systemd-run --user --scope` to run the command in a separate cgroup scope — without it, stopping `graphical-session.target` kills swaync (which is `PartOf` it), and its cgroup-based cleanup kills the child shell before `loginctl terminate-session` can run

Logs go to the journal: `journalctl -t sway-autostart --no-pager`

## Scripts

### `lid-close.sh`

Handles lid close events: disables the internal display (`eDP-1`) and suspends the system only when on battery. This is a workaround for systemd 259 not applying `HandleLidSwitchExternalPower=ignore` from `logind.conf` — logind's lid handling is set to `ignore` and sway's `bindswitch` delegates to this script instead.

### `run.sh`

Smart app launcher that either focuses the workspace if the app is already running, or launches it. Usage: `run.sh <command> <workspace> <process-name>`

### `vpn.sh`

Toggles the Red Hat Global VPN connection. Fetches the password and TOTP from `pass` (via toolbox) and connects with `nmcli`.

## Troubleshooting

### Useful Commands

```bash
# Check sway autostart logs
journalctl -t sway-autostart --no-pager

# Check sway logs
journalctl --user _COMM=sway --no-pager

# List connected outputs (monitors)
swaymsg -t get_outputs

# Inspect window properties (app_id, class, title)
swaymsg -t get_tree

# Find key names (for bindings)
wev

# Find mouse button IDs
# Run xev inside a toolbox container
toolbox run xev

# List current workspaces
swaymsg -t get_workspaces

# Test a minimal config without restarting
sway -c test-config

# Reload sway config (default binding)
$mod+Shift+c

# Check for config errors
sway -C

# Live-execute sway commands
swaymsg <command>
```

### Common Issues

- **App not tiling**: Check `windows.conf` — all windows float by default. Add a `floating disable` rule for the app's `app_id`.
- **Monitor not detected**: Run `swaymsg -t get_outputs` and add the output identifier to `output.conf`.
- **Keybinding not working**: Use `wev` to verify the key name, check for conflicts with `grep -r` across `config.d/`.
- **Lid close/open not toggling display**: The `bindswitch` rules in `output.conf` handle this for `eDP-1`. Lid close runs `lid-close.sh` which also suspends on battery (workaround for systemd 259 `HandleLidSwitchExternalPower` bug).
- **Autostart command failing**: Check `journalctl -t sway-autostart --no-pager` for errors.
