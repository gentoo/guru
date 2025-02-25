# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Tool to communicate with Qualcomm System On a Chip bootroms"
HOMEPAGE="https://github.com/linux-msm/qdl"
SRC_URI="https://github.com/linux-msm/qdl/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/libusb
	dev-libs/libxml2
"
RDEPEND="${DEPEND}"

BDEPEND="virtual/pkgconfig"

src_compile() {
	PKG_CONFIG=$(tc-getPKG_CONFIG)
	emake CC=$(tc-getCC) \
		"CFLAGS=${CFLAGS} `${PKG_CONFIG} --cflags libxml-2.0 libusb-1.0`" \
		"LDFLAGS=${LDFLAGS} `${PKG_CONFIG} --libs libxml-2.0 libusb-1.0`"
}

src_install() {
	emake prefix="${EPREFIX}/usr" DESTDIR="${D}" install
	dodoc {README,LICENSE}
}
