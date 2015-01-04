#!/bin/sh
#
# Script to build the demo firmwares for the LCA2015 OpenHardware preentation

set -e

DLDIR=${DLDIR:-/scratch/DL/openwrt DL_symlink}
REPO=${REPO:-https://github.com/pastcompute/openwrt-cc-linux-3.14.x-grsecurity.git}
KVER=3.14.27

test -e openwrt || git clone $REPO openwrt

cd openwrt

git reset --hard HEAD

test -e DL_symlink || ln -s $DLDIR DL_symlink

function prepare_for_build()
{
  make defconfig clean
  rm -rf build_dir/toolchain-mips_34kc_gcc-4.8-linaro_uClibc-0.9.33.2/linux-{$KVER,dev}
  cp ../$1.config .config
  echo src-link customfeed ../../packages > feeds.conf
  rsync -av ../files .
  scripts/feeds update -a
  scripts/feeds install -a -p customfeed
}

function perform_build()
{
  make -j
  rsync -av bin/$1/ ../bin/
  sudo cp bin/$1/openwrt-ar71xx-generic-carambola2-initramfs-uImage.bin /srv/tftp/$1
}

git checkout upstream

prepare_for_build demoA
make defconfig
perform_build demoA

prepare_for_build demoB
make defconfig
perform_build demoB

make defconfig clean
git checkout ar71xx-3.14.27-grsecurity
prepare_for_build demoC
#make kernel_menuconfig # Automatic, without CONFIG_GRKERNSEC_RANDSTRUCT, add CONFIG_GRKERNSEC_AUDIT_MOUNT:CONFIG_GRKERNSEC_FORKFAIL CONFIG_GRKERNSEC_MODHARDEN=n
#cp target/linux/ar71xx/config-3.14 ../demoC.linux.config-3.14
cp ../demoC.linux.config-3.14 target/linux/ar71xx/config-3.14 
make defconfig
# make toolchain/compile -j
perform_build demoC


