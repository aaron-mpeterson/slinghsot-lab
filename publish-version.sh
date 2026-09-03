#!/bin/bash

set -euo pipefail

VERSION="${1:?usage: publish-image.sh VERSION}"
KVER="6.12.0-160000.37-default"
DIR="/var/lib/lab-images/lab-compute-${VERSION}"
ROOT="${DIR}/build/image-root"

systemd-nspawn -D "$ROOT" -- dracut --force --no-hostonly --kver "$KVER" \
  --add "livenet dmsquash-live network-legacy" \
  --omit "systemd-networkd network-manager" /boot/netboot.initrd

cd "$DIR"
cp build/image-root/boot/netboot.initrd ./initrd-netboot
cp "node-image-test.x86_64-${VERSION}-${KVER}.kernel" ./vmlinuz
cp "node-image-test.x86_64-${VERSION}" ./rootfs.squashfs
chmod 644 vmlinuz initrd-netboot rootfs.squashfs

sed -i "s|lab-compute-[0-9.]*|lab-compute-${VERSION}|g" /var/lib/lab-images/boot.ipxe

echo "Published ${VERSION}:"
ls -lh vmlinuz initrd-netboot rootfs.squashfs
grep -o 'lab-compute-[0-9.]*' /var/lib/lab-images/boot.ipxe | sort -u
