#!/bin/bash
#
# Script to build the demo firmwares for the LCA2015 OpenHardware preentation

set -e

DLDIR=${DLDIR:-/scratch/DL/openwrt}
REPO=${REPO:-https://github.com/pastcompute/openwrt-cc-linux-3.14.x-grsecurity.git}
KVER=3.14.27
C=${MAKE_CONCURRENCY:-4}

test -e openwrt || git clone $REPO openwrt

cd openwrt

function prepare_for_build()
{
  echo "{PREPARE : $1}"

  test -e DL_symlink || ln -s $DLDIR DL_symlink
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
  echo "{BUILD : $1}"

  make -j$C
  rsync -av bin/$1 ../bin/
  cp bin/$1/openwrt-ar71xx-generic-carambola2-initramfs-uImage.bin ../$1
  sudo cp bin/$1/openwrt-ar71xx-generic-carambola2-initramfs-uImage.bin /srv/tftp/$1

  echo "{FIRMWARE IMAGE: /srv/tftp/$1}"
}

git checkout upstream
git reset --hard HEAD

prepare_for_build demoA
make defconfig
perform_build demoA

git checkout ar71xx-$KVER-grsecurity
git reset --hard HEAD

prepare_for_build demoB
make defconfig
# There needs to be a symlink for module dependencies to work
( cd files ; mkdir -p lib/modules ; cd lib/modules ; ln -sf $KVER $KVER-grsec )
perform_build demoB

git checkout ar71xx-$KVER-grsecurity
git reset --hard HEAD

make defconfig clean
prepare_for_build demoC
#make kernel_menuconfig # Automatic, without CONFIG_GRKERNSEC_RANDSTRUCT, add CONFIG_GRKERNSEC_AUDIT_MOUNT:CONFIG_GRKERNSEC_FORKFAIL CONFIG_GRKERNSEC_MODHARDEN=n
#cp target/linux/ar71xx/config-3.14 ../demoC.linux.config-3.14
cp ../demoC.linux.config-3.14 target/linux/ar71xx/config-3.14 
make defconfig
# make toolchain/compile -j
# There needs to be a symlink for module dependencies to work
( cd files ; mkdir -p lib/modules ; cd lib/modules ; ln -sf $KVER $KVER-grsec )
perform_build demoC

