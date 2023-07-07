# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="QPACK compression library for use with HTTP/3"
HOMEPAGE="https://github.com/litespeedtech/ls-qpack/"
SRC_URI="https://github.com/litespeedtech/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="static-libs"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=$(usex !static-libs)
	)
	cmake_src_configure
}

src_install() {
	mkdir -p ${D}/usr/include/
	mkdir -p ${D}/usr/lib64/
	cp ${S}_build/libls* ${D}/usr/lib64/
	cp ${S}/lsxpack_header.h ${D}/usr/include/
	cp ${S}/lsqpack.h ${D}/usr/include/
	einstalldocs
}
