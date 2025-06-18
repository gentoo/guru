# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Libraries and tools for C/C++ development on RP2040 and RP2350 microcontrollers."
HOMEPAGE="https://github.com/raspberrypi/pico-sdk"

EGIT_REPO_URI="https://github.com/raspberrypi/pico-sdk.git"
EGIT_BRANCH="master"
EGIT_COMMIT="${PV}"

LICENSE="BSD"
SLOT="0"

src_install() {
	dodir /opt/pico-sdk
	cp -r "${S}/." "${D}/opt/pico-sdk/"
	find "${D}/opt/pico-sdk" -type d -name ".git" -exec rm -rf '{}' +

	echo "PICO_SDK_PATH=/opt/pico-sdk" > "${T}/99pico-sdk" || die
	doenvd "${T}/99pico-sdk"
}

pkg_postinst() {
	elog "If you want to use the Pico SDK now, run:"
	elog "    source /etc/profile"
}
