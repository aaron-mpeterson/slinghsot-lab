#!/bin/bash
set -euxo pipefail

# Load kiwi helper functions
declare kiwi_iname=${kiwi_iname}
test -f /.kconfig && . /.kconfig

echo "Configure image: [$kiwi_iname]..."

systemctl enable sshd
systemctl enable systemd-networkd
systemctl enable systemd-resolved

# Overlay file permissions — git doesn't preserve modes reliably
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys

# Stamp the image so a booted node can identify itself
echo "lab-compute ${kiwi_iversion} built $(date -u +%Y-%m-%dT%H:%M:%SZ)" > /etc/motd
