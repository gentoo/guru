# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd udev

DESCRIPTION="Meta-package for installing phosh on pinephone"
HOMEPAGE="https://gitlab.manjaro.org/manjaro-arm/packages/community/phosh/pinephone-manjaro-tweaks.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64"
IUSE="+eg25-manager"

RDEPEND="
	gnome-extra/iio-sensor-proxy
	gui-wm/phosh-meta
	app-mobilephone/usb-tethering
	media-libs/alsa-ucm-pinephone
	media-tv/v4l-utils
	sys-firmware/anx7688-firmware
	sys-firmware/rtl8723bt-firmware
	sys-firmware/ov5640-firmware
	x11-themes/sound-theme-librem5
	eg25-manager? (
		net-misc/eg25-manager
		>=app-mobilephone/pinephone-modem-scripts-0.20.3-r5
	)
	!eg25-manager? (
		<=app-mobilephone/pinephone-modem-scripts-0.20.3-r4
		!net-misc/eg25-manager
	)
	sys-boot/osk-sdl
"
