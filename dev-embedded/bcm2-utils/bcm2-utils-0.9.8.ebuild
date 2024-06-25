# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Utilities for Broadcom-based cable modems"
HOMEPAGE="https://github.com/jclehner/bcm2-utils"
SRC_URI="https://github.com/jclehner/bcm2-utils/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/boost"
RDEPEND="${DEPEND}"

src_prepare(){
	default
	sed -i 's@shell git describe --always@shell git describe --always 2>/dev/null@' "Makefile" || die
}

src_compile(){
	emake CC=$(tc-getCC) CXX=$(tc-getCXX) CFLAGS=${CFLAGS} CXXFLAGS=${CXXFLAGS} \
		LDFLAGS=${LDFLAGS}
}

src_install(){
	mkdir -p "${D}/usr/bin" || die
	emake PREFIX="${D}/usr" install
}
