#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "Please execute as root"
	exit 1
fi

dependencies=(
	xorg-xkbcomp
	xorg-setxkbmap
	xf86-input-libinput
	xtrans
	libxfont2
	xorg-font-util
	libxcvt
)

pacman --noconfirm -S "${dependencies[@]}"

arch-meson \
	--buildtype=release \
	-Dxorg=true \
	-Dxdmcp=false \
	-Dxvfb=false \
	-Dlinux_acpi=false \
	-Dhal=false \
	-Dxnest=false \
	-Dlinux_apm=false \
	-Dxkb_dir=/usr/share/X11/xkb \
	-Dxkb_output_dir=/var/lib/xkb \
	build

ninja install -C build
