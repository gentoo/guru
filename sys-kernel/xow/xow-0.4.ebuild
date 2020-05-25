# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Linux driver for the Xbox One wireless dongle"
HOMEPAGE="https://github.com/medusalix/xow"
SRC_URI="https://github.com/medusalix/xow/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/libusb:1"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	emake BUILD=RELEASE
}

src_install() {
	emake DESTDIR="${D}" PREFIX="" install
}
