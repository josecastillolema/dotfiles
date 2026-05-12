Name:           atmos-agent
Version:        3.96.5
Release:        1.ostree
Summary:        Axis Security - Atmos Agent
License:        unknown
AutoReqProv:    no
%global debug_package %{nil}
%define __strip /bin/true
%define __brp_mangle_shebangs /bin/true
%define __brp_strip /bin/true
%define __brp_strip_comment_note /bin/true
%define __brp_strip_lto /bin/true
%define _build_id_links none

%description
Axis Security - Atmos Agent (repackaged for rpm-ostree)

%install
cp -a %{_sourcedir}/usr %{buildroot}/usr

%files
/usr/lib/AxisSecurity
/usr/lib/systemd/system/atmosd.service
/usr/lib/systemd/user/atmos-agent.service
/usr/share/applications/AtmosAgent.desktop
/usr/share/applications/AtmosAgentGUI.desktop
/usr/share/icons/AtmosAgent.png

%post
set -e

# Install SELinux policy and relabel agentd binary
if [ -x "$(command -v semodule)" ]; then
  semodule -i /usr/lib/AxisSecurity/atmosd.pp 2>/dev/null &&
    restorecon -F -R -v /usr/lib/AxisSecurity/agentd 2>/dev/null ||
    echo "Warning: failed installing atmos selinux module."
fi

# Autostart, symlinks and permissions
ln -sf /usr/share/applications/AtmosAgent.desktop /etc/xdg/autostart/AtmosAgent.desktop
chmod a-wx /usr/lib/systemd/system/atmosd.service
chmod a-wx /usr/lib/systemd/user/atmos-agent.service
chmod a-wx /etc/xdg/autostart/AtmosAgent.desktop
ln -sf /usr/lib/AxisSecurity/run-atmos /usr/bin/atmos

systemctl daemon-reload
systemctl enable atmosd.service

%preun
if [ "${1}" -eq 0 ]; then
  systemctl stop atmosd.service 2>/dev/null || true
  systemctl disable atmosd.service 2>/dev/null || true
fi
