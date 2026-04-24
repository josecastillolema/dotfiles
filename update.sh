set -v
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates
sudo fwupdmgr update
rpm-ostree upgrade
flatpak uninstall --unused -y
flatpak update -y
claude update
#curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir ~/.local/bin
uv self update
uv tool upgrade --all
