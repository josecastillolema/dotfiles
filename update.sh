set -v
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates
sudo fwupdmgr update
rpm-ostree upgrade
flatpak uninstall --unused -y
flatpak update -y
npm install @anthropic-ai/claude-code --prefix ~
