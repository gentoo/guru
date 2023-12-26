# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Hayes Smartmodem emulator over TCP/IP"
HOMEPAGE="https://github.com/go4retro/tcpser"
SRC_URI="https://github.com/go4retro/tcpser/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	# Fix CR-LF incompatibility with patch
	eapply --binary "${FILESDIR}/${P}_dont-hardcode-cflags-and-ldflags.patch"

	make all CC=$(tc-getCC)
}

src_install() {
	dobin tcpser
	doman man/tcpser.1
	dodoc README.md
}
