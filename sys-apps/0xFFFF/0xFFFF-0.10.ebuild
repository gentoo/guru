# Copyright 2013-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="0pen Free Fiasco Firmware Flasher for Maemo devices"
HOMEPAGE="https://github.com/pali/0xFFFF"
SRC_URI="https://github.com/pali/${PN}/releases/download/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/libusb:0"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i 's/-O2//' src/Makefile || die
	default
}

src_compile() {
	tc-export CC
	default
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
