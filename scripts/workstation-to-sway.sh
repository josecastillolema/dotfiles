#!/bin/bash
#
# Converts a Fedora Workstation (GNOME) into a Sway desktop,
# mirroring the Fedora Sway Atomic (Sericea) package set.
#
# Usage: sudo bash workstation-to-sway.sh
#
# Designed to be idempotent: safe to re-run if interrupted.

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
    echo "Error: must run as root (sudo)"
    exit 1
fi

BOLD='\033[1m'
RESET='\033[0m'

step() { printf "\n${BOLD}==> %s${RESET}\n" "$1"; }

# ── Phase 0: Clean package cache ───────────────────────────────────

step "Syncing system clock"
timedatectl set-ntp true
hwclock --hctosys 2>/dev/null || true

step "Refreshing RPM GPG keys and metadata"
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-*
dnf clean metadata

step "Updating system"
dnf upgrade -y

# ── Phase 1: Install Sway ──────────────────────────────────────────

step "Switching release identity to Fedora Sway"
dnf swap -y fedora-release-identity-workstation fedora-release-identity-sway 2>/dev/null || true
dnf swap -y fedora-release-workstation fedora-release-sway 2>/dev/null || true

step "Installing Sway Window Manager groups"
dnf group install -y swaywm swaywm-extended

step "Removing tuned (conflicts with TLP)"
dnf remove -y tuned tuned-ppd tuned-switcher 2>/dev/null || true

step "Adding Copr repos"
dnf copr enable -y yuezk/globalprotect-openconnect

step "Installing AutoFirma (check https://firmaelectronica.gob.es/descargas for newer versions)"
AUTOFIRMA_URL="https://firmaelectronica.gob.es/content/dam/firmaelectronica/descargas-software/autofirma19/Autofirma_Linux_Fedora.zip"
curl -Lo /tmp/autofirma.zip "$AUTOFIRMA_URL"
unzip -o /tmp/autofirma.zip -d /tmp/autofirma
dnf install -y /tmp/autofirma/*.rpm
rm -rf /tmp/autofirma /tmp/autofirma.zip

step "Installing layered packages (matching Sway Atomic)"
dnf install -y \
    bat \
    fd-find \
    fzf \
    globalprotect-openconnect \
    gvfs-mtp \
    java \
    jetbrains-mono-fonts \
    libvirt-daemon-kvm \
    lsd \
    net-tools \
    papirus-icon-theme \
    SwayNotificationCenter \
    tlp \
    wtype

# ── Phase 2: Remove replaced packages ─────────────────────────────
# Must run after group install, since swaywm pulls in firefox as a dependency

step "Disabling Google Chrome repo (Chrome is a Flatpak)"
dnf config-manager setopt google-chrome.enabled=0 2>/dev/null || true

step "Removing packages replaced on Sway Atomic"
dnf remove -y dunst firefox firefox-langpacks google-chrome-stable mpv nautilus-extensions nautilus-python thunar-archive-plugin vim-X11 2>/dev/null || true

step "Removing CSB base image bloat"
dnf remove -y leaktk-gitleaks7 rh-gitleaks rh-pre-commit 2>/dev/null || true

step "Trimming GNOME extras (keeping gnome-shell + mutter + gdm for compliance)"
dnf remove --setopt=clean_requirements_on_remove=false -y \
    baobab \
    gnome-boxes \
    gnome-browser-connector \
    gnome-calculator \
    gnome-calendar \
    gnome-characters \
    gnome-classic-session \
    gnome-clocks \
    gnome-color-manager \
    gnome-connections \
    gnome-contacts \
    gnome-extensions-app \
    gnome-font-viewer \
    gnome-initial-setup \
    gnome-logs \
    gnome-maps \
    gnome-remote-desktop \
    gnome-shell-extension-appindicator \
    gnome-shell-extension-no-overview \
    gnome-software \
    gnome-software-fedora-langpacks \
    gnome-system-monitor \
    gnome-text-editor \
    gnome-tweaks \
    gnome-user-docs \
    gnome-user-share \
    gnome-weather \
    loupe \
    nautilus \
    snapshot \
    yelp \
    2>/dev/null || true

# ── Phase 3: Keep GDM, ensure Sway session is available ───────────

step "Ensuring GDM is enabled (enterprise requirement)"
systemctl disable sddm 2>/dev/null || true
systemctl enable gdm 2>/dev/null || true

step "Verifying Sway session file for GDM"
ls /usr/share/wayland-sessions/sway.desktop 2>/dev/null \
    && echo "Sway session available in GDM" \
    || echo "WARNING: sway.desktop not found in wayland-sessions"

# ── Phase 4: Enable TLP ────────────────────────────────────────────

step "Enabling TLP"
systemctl enable --now tlp 2>/dev/null || true

# ── Phase 5: Post-install setup ────────────────────────────────────

step "Cleaning up"
dnf autoremove -y
dnf clean all

step "Done! Reboot and select 'Sway' from the GDM session menu."
echo "After reboot, re-establish the reverse SSH tunnel if needed:"
echo "  ssh -R 2222:localhost:22 <user>@<host-ip>"
echo ""
echo "IMPORTANT: Before running the dotfiles apply scripts, update hardcoded"
echo "/home/<user> paths for this machine's username in:"
echo "  - gtk-3.0/bookmarks"
echo "  - desktop/app.zen_browser.zen.desktop"
echo "  - transmission/settings.json"
echo "  - flatpak/overrides/io.neovim.nvim"
echo "  - flatpak/overrides/com.helix_editor.Helix"
echo "  - flatpak/overrides/com.visualstudio.code"
echo "  sed -i \"s|/home/jose|/home/\$(whoami)|g\" can help."
echo ""
read -rp "Press Enter once you have updated the paths (or Ctrl+C to abort)..."
