# Before running this, update the system

# Verify the branch for the next major version is available
# ostree remote refs fedora | grep sericea | grep $(uname -m)

# Upgrade
rpm-ostree rebase fedora:fedora/41/x86_64/sericea
