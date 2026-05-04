# Zen Browser

Zen Browser configuration for the Flatpak installation (`app.zen_browser.zen`).

## Structure

```
zen/
├── autoconfig/              # fx-autoconfig loader (placed in wrapper dir at launch)
│   ├── config.js
│   └── defaults/pref/
│       └── config-prefs.js
├── chrome/
│   ├── JS/
│   │   └── openInFirefox.uc.js  # "Open Link in Firefox" context menu item
│   └── utils/                   # fx-autoconfig runtime (from github.com/MrOtherGuy/fx-autoconfig)
├── launch.sh                # Wrapper launch script (rebuilds on every start)
├── user.js                  # Browser preferences
└── README.md
```

## How it works

Zen's Flatpak install directory (`/app/zen/`) is read-only, but the
[fx-autoconfig](https://github.com/MrOtherGuy/fx-autoconfig) loader requires
`config.js` next to the browser binary. To work around this, `launch.sh` creates
a writable wrapper directory (`~/.local/share/zen-wrapper/`) on every launch that
mirrors `/app/zen/` via symlinks, copies the actual binaries, and adds the
autoconfig files. Zen is then launched from the wrapper so that `/proc/self/exe`
resolves to the writable directory.

The `.desktop` override in `desktop/app.zen_browser.zen.desktop` calls `launch.sh`
instead of the default Flatpak launch script.

The `chrome/utils/` and `chrome/JS/` directories are symlinked into each Zen
profile by `apply/symlink.sh`.

## Setup

Run `apply/symlink.sh` from the `apply/` directory. This symlinks `user.js`,
`chrome/utils/`, and `chrome/JS/openInFirefox.uc.js` into each Zen profile. The
`.desktop` override is deployed automatically since `desktop/` is already
symlinked to `~/.local/share/applications/`.

No additional steps are needed after that — `launch.sh` rebuilds the wrapper
directory on every launch, so Flatpak updates to Zen are handled transparently.

## After a Zen Flatpak update

Nothing to do. The wrapper is rebuilt on every launch, so new binaries from
`/app/zen/` are automatically picked up. Just restart Zen.

If you manually create a new Zen profile, re-run `apply/symlink.sh` to symlink
the chrome files into it.

## userChrome.js scripts

Scripts in `chrome/JS/` run with full browser (chrome) privileges — they can
access XPCOM interfaces, modify the UI, and spawn processes. To add a new script,
place a `.uc.js` file in `chrome/JS/` and restart Zen.

### openInFirefox.uc.js

- Adds an **"Open Link in Firefox"** item to the right-click context menu on links.
- Adds an **"Open in Firefox"** button to the Zen Glance (preview) sidebar,
  alongside the existing close/expand/split buttons. Clicking it opens the
  previewed page in Firefox and closes the Glance panel.

Both use `xdg-open` which routes through the XDG Desktop Portal to the default
browser (Firefox).
