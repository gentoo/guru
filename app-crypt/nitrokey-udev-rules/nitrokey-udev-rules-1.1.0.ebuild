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

src_test() {
	# Default 'make check' depends on ruff and pyright, and checks the python
	# rule generator script. Since upstream generates and includes the udev rules
	# in the source tarball, this isn't necessary.
	# Instead run 'udevadm verify', which makes more sense, and what upstream
	# added as the 'verify' Makefile target post-1.1.0.
	udevadm verify 41-nitrokey.rules
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
