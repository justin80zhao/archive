#!/bin/bash
#description: build and install kernel.
#author: Justin Zhao
#date: 2015-5-29

pwd

tmpstr=`sed -n '1p' Makefile`
VERSIONSTR=${tmpstr#'VERSION = '}

tmpstr=`sed -n '2p' Makefile`
VERSIONSTR=$VERSIONSTR"."${tmpstr#'PATCHLEVEL = '}

tmpstr=`sed -n '3p' Makefile`
VERSIONSTR=$VERSIONSTR"."${tmpstr#'SUBLEVEL = '}

tmpstr=`sed -n '4p' Makefile`
tmpstr=${tmpstr#'EXTRAVERSION ='}
if [ -n "$tmpstr" ]; then
	tmpstr=${tmpstr##' '}
	if [ -n "$tmpstr" ]; then
		VERSIONSTR=$VERSIONSTR$tmpstr
	fi
fi

git status | grep 'modified'
if [ "$?" = "0" ]; then
	VERSIONSTR=$VERSIONSTR"+"
fi

echo "To build target: "$VERSIONSTR
#exit

export ARCH=arm64
march=`uname -m`
if [ "$march" != "aarch64" ]; then
	export CROSS_COMPILE=aarch64-linux-gnu-
fi

#cp .config config.tmp
sudo make mrproper
#mv config.tmp .config
cp config.dbg arch/arm64/configs/defconfig
make defconfig
#sed -i 's/=m/=y/g' .config
#make defconfig
#exit
#make Image -j16

rm *.out
sudo rm -f /boot/*
make Image -j16 > build0.out 2>&1
sudo make modules -j16 > build1.out 2>&1
sudo make modules_install > build2.out 2>&1

sudo mkdir -p /lib/firmware/"$VERSIONSTR"/device-tree/
make apm/apm-mustang.dtb
sudo cp arch/arm64/boot/dts/apm/apm-mustang.dtb /boot/apm-mustang-"$VERSIONSTR".dtb
sudo cp arch/arm64/boot/dts/apm/apm-mustang.dtb /lib/firmware/"$VERSIONSTR"/device-tree/apm-mustang-"$VERSIONSTR".dtb
sudo make install > build3.out 2>&1

sudo cp /boot/* ~/boot.bak/
sudo rm -f /boot/*

#sudo aarch64-linux-gnu-objcopy -O binary -R .comment -S /boot/vmlinuz-3.19.0-rc4+ arch/arm64/boot/zImage
sudo mkimage -A arm -O linux -T ramdisk -C gzip -a 0 -e 0 -n "ramdisk $VERSIONSTR" -d ~/boot.bak/initrd.img-"$VERSIONSTR" /boot/uInitrd-"$VERSIONSTR" 
sudo mkimage -A arm -O linux -T kernel -C none -a 0x00080000 -e 0x00080000 -n "kernel $VERSIONSTR" -d ~/boot.bak/vmlinuz-"$VERSIONSTR" /boot/uImage-"$VERSIONSTR"
sudo cp ~/boot.bak/apm-mustang-"$VERSIONSTR".dtb /boot/
sudo cp ~/boot.bak/config-"$VERSIONSTR" /boot/
sudo depmod "$VERSIONSTR"

#recover old images
sudo cp /boot/orig/apm-mustang.dtb /boot/
sudo cp /boot/orig/boot.scr /boot/
sudo cp /boot/orig/config-3.19.0-10-generic /boot/
sudo cp /boot/orig/uImage /boot/
sudo cp /boot/orig/uInitrd /boot/

sync

sudo rm -rf /boot/*.old
sudo ls -al /boot
