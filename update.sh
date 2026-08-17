set -v
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates
sudo fwupdmgr update
if command -v rpm-ostree &>/dev/null; then
    rpm-ostree upgrade
else
    sudo dnf upgrade -y
fi
flatpak uninstall --unused -y
flatpak update -y
claude update
#agy update
#curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir ~/.local/bin
uv self update
uv tool upgrade --all
npm update -g
#rustup update
go version -m $(GOPATH=$(go env GOPATH) && echo $GOPATH/bin/*) 2>/dev/null | grep -o 'path [^ ]*' | cut -d' ' -f2 | xargs -I{} go install {}@latest
