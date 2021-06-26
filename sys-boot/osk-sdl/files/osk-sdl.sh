#!/bin/bash
# stolen from postmarket
# https://gitlab.com/postmarketOS/pmaports/-/blob/master/main/postmarketos-mkinitfs/init_functions.sh
find_crypt_partition() {
	# The partition layout is one of the following:
	# a) boot, root partitions on sdcard
	# b) boot, root partition on the "system" partition (which has its
	#    own partition header! so we have partitions on partitions!)
	#
	# mount_subpartitions() must get executed before calling
	# find_root_partition(), so partitions from b) also get found.

	# Short circuit all autodetection logic if pmos_root= is supplied
	# on the kernel cmdline
	# shellcheck disable=SC2013
	for x in $(cat /proc/cmdline); do
		[ "$x" = "${x#cryptroot=}" ] && continue
		DEVICE="${x#cryptroot=}"
	done
	echo "$DEVICE"
}

setup_directfb_tslib() {
	# Set up directfb and tslib
	# Note: linux_input module is disabled since it will try to take over
	# the touchscreen device from tslib (e.g. on the N900)
	export SDL_VIDEO_DRIVER="kmsdrm"
	export SDL_RENDER_DRIVER="software"
	#export DFBARGS="system=fbdev,no-cursor,disable-module=linux_input"
	# shellcheck disable=SC2154
	if [ -n "$deviceinfo_dev_touchscreen" ]; then
		export TSLIB_TSDEVICE="$deviceinfo_dev_touchscreen"
	fi
}

start_onscreen_keyboard() {
	setup_directfb_tslib
	sleep 1 # wait for dev settle
	/usr/bin/osk-sdl -n root -d "$partition" -c /etc/osk.conf 
	unset DFBARGS
	unset TSLIB_TSDEVICE
}

unlock_root_partition() {
	partition="$(find_crypt_partition)"
	start_onscreen_keyboard
}

unlock_root_partition
