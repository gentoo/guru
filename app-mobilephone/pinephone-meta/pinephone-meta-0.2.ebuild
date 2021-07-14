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
	app-mobilephone/pinephone-modem-scripts
	app-mobilephone/usb-tethering
	gnome-extra/iio-sensor-proxy
	gui-wm/phosh-meta
	media-libs/alsa-ucm-pinephone
	media-tv/v4l-utils
	net-misc/eg25-manager
	sys-firmware/pinephone-firmware
	x11-themes/sound-theme-librem5
"
