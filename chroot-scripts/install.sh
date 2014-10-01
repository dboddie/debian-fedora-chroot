#!/bin/bash

set -e

yum -y check-update
yum -y install sudo man less vim

useradd -m -s /bin/bash build

echo "build ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
echo 'Defaults:build !requiretty' >> /etc/sudoers
