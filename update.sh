set -v
sudo fwupdmgr refresh
sudo fwupdmgr update
rpm-ostree upgrade
flatpak update -y
