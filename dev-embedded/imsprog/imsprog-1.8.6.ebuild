# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake udev

MY_PN="IMSProg"
DESCRIPTION="I2C, MicroWire and SPI EEPROM/Flash chip Programmer"
HOMEPAGE="https://github.com/bigbigmdm/IMSProg"
#HASH_COMMIT="tbd"
if [[ ${PV} == *_p* ]]; then
	SRC_URI="https://github.com/bigbigmdm/IMSProg/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_PN}-${HASH_COMMIT}"
else
	SRC_URI="https://github.com/bigbigmdm/IMSProg/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_PN}-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[gui,network,ssl,widgets]
	>=virtual/libusb-1-r2:1
"
RDEPEND="${DEPEND}
	virtual/udev
"
BDEPEND="
	app-alternatives/gzip
	dev-qt/qttools:6[linguist]
	virtual/pkgconfig
"

src_install() {
	local HTML_DOCS=( IMSProg_programmer/other/index.html img/* )
	cmake_src_install
	rm -r "${ED}"/usr/share/doc/imsprog || die
	gunzip "${ED}"/usr/share/man/man1/* || die
}

pkg_postrm() {
	udev_reload
}

pkg_postinst() {
	udev_reload
}
