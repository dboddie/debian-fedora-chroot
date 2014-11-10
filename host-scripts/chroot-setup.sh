#!/bin/sh

. $PWD/fedora-chroot-common.sh

export PREFIX=$PWD

echo "---------------------------------------------------------"
echo "Installing chroot at $CHROOT"
echo "---------------------------------------------------------"

set -e

if [ ! -e $RELEASE_RPM ]; then
  wget $MIRROR/$RELEASE_RPM
fi

# Install the package in the chroot, creating the directory as needed.
sudo rpm -pi --root $CHROOT $RELEASE_RPM

# Substitute the release number into the repo files in the chroot.
sudo sed -i s/\$releasever/$RELEASE_VERSION/ $CHROOT/etc/yum.repos.d/*.repo

# Temporarily link the directory in the chroot containing repository keys to
# a directory in the host file system.
if [ -e /etc/pki]; then
  echo "The /etc/pki directory already exists. Exiting..."
  exit 1
fi

echo "Temporarily creating a /etc/pki directory."
sudo ln -s $CHROOT/etc/pki /etc/pki

# Install yum in the chroot.
sudo yum -y --installroot=$CHROOT install yum

#cp /etc/resolv.conf $CHROOT/etc/resolv.conf
#echo "DNS configuration copied"

$PREFIX/host-scripts/chroot-mount-proc.sh

echo "cp $PREFIX/chroot-scripts/*.sh $CHROOT/root/"
cp $PREFIX/chroot-scripts/*.sh $CHROOT/root/
echo "Files copied"

echo "Running installation scripts inside the chroot."
chroot $CHROOT /root/install.sh

echo "Removing the /etc/pki link."
sudo rm /etc/pki

echo "chroot $CHROOT is ready to use."
echo "Run host-scripts/chroot-enter.sh to enter it."
