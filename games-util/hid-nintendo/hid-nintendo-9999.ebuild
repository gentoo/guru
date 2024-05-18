# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 linux-mod

DESCRIPTION="A Nintendo HID kernel module"
HOMEPAGE="https://github.com/nicman23/dkms-hid-nintendo https://github.com/DanielOgorchock/linux"
EGIT_REPO_URI="https://github.com/nicman23/dkms-hid-nintendo"

LICENSE="GPL-2"
SLOT="0"

MODULE_NAMES="${PN}(kernel/drivers/hid:${S}/src)"
BUILD_TARGETS="-C /usr/src/linux M=${S}/src"

pkg_setup() {
	CONFIG_CHECK="~HID ~HID_GENERIC ~USB_HID ~HIDRAW ~UHID"
	check_extra_config
	linux-mod_pkg_setup
}
