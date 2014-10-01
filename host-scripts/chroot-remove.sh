#!/bin/sh

set -e

. $PWD/fedora-chroot-common.sh

echo "---------------------------------------------------------"
echo "Uninstalling $CHROOT"
echo "---------------------------------------------------------"

chroot $CHROOT /root/uninstall.sh
umount -l $CHROOT/proc
echo "Unmounted /proc"

umount -l $CHROOT/dev
echo "Unmounted /dev"

rm -rf $CHROOT
echo "Removed $CHROOT"
