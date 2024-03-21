# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Extract ALZ archives"
HOMEPAGE="http://kippler.com/win/unalz/"
SRC_URI="http://kippler.com/win/${PN}/${P}.tgz
	https://alarmpi.no-ip.org/gentoo/${PN}-0.65-use-system-zlib.patch.bz2
	https://alarmpi.no-ip.org/gentoo/${PN}-0.65-use-system-bz2.patch.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/bzip2 sys-libs/zlib virtual/libiconv"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-0.65-buildfix-wrong-data-type.patch
	"${WORKDIR}"/${PN}-0.65-use-system-zlib.patch
	"${WORKDIR}"/${PN}-0.65-use-system-bz2.patch
)

S="${WORKDIR}"/${PN}

src_compile() {
	emake linux-utf8 LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin "${S}"/unalz
}
