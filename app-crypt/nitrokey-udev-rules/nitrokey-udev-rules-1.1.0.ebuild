# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit udev

DESCRIPTION="udev rules for Nitrokey devices"
HOMEPAGE="https://github.com/Nitrokey/nitrokey-udev-rules"

SRC_URI="https://github.com/Nitrokey/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	virtual/udev
"

src_configure() { :; }

src_compile() { :; }

src_install() {
	udev_dorules 41-nitrokey.rules
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
