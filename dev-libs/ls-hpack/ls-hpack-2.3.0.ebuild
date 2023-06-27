# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="QPACK compression library for use with HTTP/3"
HOMEPAGE="https://github.com/litespeedtech/ls-hpack/"
SRC_URI="https://github.com/litespeedtech/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs"

PATCHES=(
	"${FILESDIR}"/${PN}-disable-tests.patch
)

src_configure() {
	local mycmakeargs=(
		-DSHARED=$(usex !static-libs 1 0)
	)
	cmake_src_configure
}

src_install() {
	mkdir -p ${D}/usr/include/lshpack/
	mkdir -p ${D}/usr/lib64/
	cp ${S}_build/libls-hpack* ${D}/usr/lib64/
	cp ${S}/lshpack.h ${D}/usr/include/lshpack/
	cp ${S}/lshpack.h ${D}/usr/include/
	einstalldocs
}
