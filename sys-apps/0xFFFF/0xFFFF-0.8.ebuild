# Copyright 2013-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="The 0pen Free Fiasco Firmware Flasher"
HOMEPAGE="https://github.com/pali/0xFFFF/"
SRC_URI="https://github.com/pali/${PN}/releases/download/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/libusb:0"
RDEPEND="${DEPEND}"

src_compile() {
	tc-export CC
	default
}

src_install() {
	emake DESTDIR="${ED}" PREFIX="/usr" install
}
