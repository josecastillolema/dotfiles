# Atmos VPN Agent

VPN agent by [Axis Security](https://docs.axissecurity.com/docs/atmos-agent-installation-for-linux) (now HPE Aruba Networking). The upstream RPM's `%post` script fails on rpm-ostree because it tries to `mkdir` on the read-only `/var`. The spec file repackages the RPM with a compatible `%post` that handles SELinux policy installation and `restorecon`.

## Repackage (inside toolbox)

```bash
sudo dnf install -y rpm-build
mkdir -p /tmp/atmos-repack && cd /tmp/atmos-repack
rpm2cpio ~/Downloads/nvidia.atmos-agent-*.x86_64.rpm | cpio -idmv
rpmbuild -bb ~/dev/dotfiles/atmos/atmos-agent-ostree.spec \
  --define "_sourcedir /tmp/atmos-repack" \
  --define "_topdir /tmp/atmos-rpmbuild" \
  --define "_build_id_links none" \
  --define "_unpackaged_files_terminate_build 0"
cp /tmp/atmos-rpmbuild/RPMS/x86_64/atmos-agent-*.ostree.x86_64.rpm ~/Downloads/
```

## Install (on host)

```bash
rpm-ostree install ~/Downloads/atmos-agent-*.ostree.x86_64.rpm
```

## After reboot

```bash
sudo mkdir -p -m 700 /var/lib/AxisSecurity/agentd
sudo mkdir -p -m 777 /var/lib/AxisSecurity/crashes
```

## Disable autostart (optional)

```bash
sudo rm /etc/xdg/autostart/AtmosAgent.desktop
sudo systemctl disable atmosd.service
```

## Upgrade

Update the `Version:` field in `atmos-agent-ostree.spec`, then repeat the repackage and install steps. Use `--uninstall atmos-agent` to swap in one transaction:

```bash
rpm-ostree install ~/Downloads/atmos-agent-*.ostree.x86_64.rpm --uninstall atmos-agent
```
