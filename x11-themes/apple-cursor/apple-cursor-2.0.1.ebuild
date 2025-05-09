# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Free & Open source macOS Cursors."
HOMEPAGE="https://github.com/ful1e5/apple_cursor"
SRC_URI="https://github.com/ful1e5/apple_cursor/releases/download/v${PV}/macOS.tar.xz -> ${P}.tar.xz"

S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	insinto "/usr/share/icons"
	doins -r macOS/
	doins -r macOS-White/
}
