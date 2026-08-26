#!/bin/bash
#
# Post-reboot dotfiles deployment for Fedora Workstation with Sway.
# Run from the dotfiles repo root after workstation-to-sway.sh + reboot.
#
# Usage: bash scripts/workstation-to-sway-dotfiles.sh
#
# Designed to be idempotent: safe to re-run.

set -euo pipefail

BOLD='\033[1m'
RESET='\033[0m'

step() { printf "\n${BOLD}==> %s${RESET}\n" "$1"; }

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

step "Installing Flatpak apps"
bash apply/flatpak.sh

step "Creating config symlinks"
cd "$REPO_ROOT/apply"
bash symlink.sh
cd "$REPO_ROOT"

echo ""
echo "Open Firefox (flatpak run org.mozilla.firefox) and sign into your account."
echo "Close Firefox when done."
read -p "Press Enter to continue..."

step "Symlinking Firefox user.js into new profile"
for dir in ~/.mozilla/firefox/*.*/; do
	ln -sf "$REPO_ROOT/firefox/user.js" "$dir/user.js"
done

echo ""
echo "Open Zen Browser (flatpak run app.zen_browser.zen) and close it when done."
read -p "Press Enter to continue..."

step "Symlinking Zen user.js into new profile"
for dir in ~/.zen/*.*/; do
	[ "$(basename "$dir")" = "*.*" ] && continue
	ln -sf "$REPO_ROOT/zen/user.js" "$dir/user.js"
done

step "Importing host CA certificates into browser profiles"
bash apply/ca-certs.sh

step "Applying local settings and installing CLI tools"
bash apply/local.sh

step "Installing Python tools via uv"
bash apply/uv.sh

step "Installing Node packages"
bash apply/node.sh

step "Reloading Sway"
swaymsg reload 2>/dev/null || true

step "Done! Log out and back in for full effect."
