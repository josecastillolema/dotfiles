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
npm update -g
rustup update
go version -m $(GOPATH=$(go env GOPATH) && echo $GOPATH/bin/*) 2>/dev/null | grep -oP '(?<=path\s)\S+' | xargs -I{} go install {}@latest
