set -v
sudo fwupdmgr refresh
sudo fwupdmgr update
rpm-ostree upgrade
flatpak uninstall --unused -y
flatpak update -y
