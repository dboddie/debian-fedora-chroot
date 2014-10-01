#!/bin/sh

. $PWD/fedora-chroot-common.sh

#mount -o bind /proc $CHROOT/proc
mount -t proc none $CHROOT/proc
echo "/proc mounted"
mount -o bind /dev $CHROOT/dev
echo "/dev mounted"
