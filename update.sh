set -v
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates
sudo fwupdmgr update
rpm-ostree upgrade
flatpak uninstall --unused -y
flatpak update -y
toolbox run npm install @anthropic-ai/claude-code --prefix ~/bin
#curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir ~/bin
#pip install --upgrade pip
#pip list --outdated | awk 'NR>2 {print $1}' | xargs -n1 pip install -U
