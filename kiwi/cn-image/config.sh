#!/bin/bash
set -ex

#======================================
# Activate services
#--------------------------------------
systemctl enable sshd
systemctl enable grub_config
systemctl enable dracut_hostonly
systemctl enable systemd-networkd


#======================================
# Set permissions
#--------------------------------------

