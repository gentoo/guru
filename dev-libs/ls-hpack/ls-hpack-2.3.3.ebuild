# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="QPACK compression library for use with HTTP/3"
HOMEPAGE="https://github.com/litespeedtech/ls-hpack/"
SRC_URI="https://github.com/litespeedtech/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="static-libs"

PATCHES=(
	"${FILESDIR}"/${PN}-disable-overwrites-flags.patch
	"${FILESDIR}"/${PN}-disable-tests.patch
)

src_configure() {
	local mycmakeargs=(
		-DSHARED=$(usex !static-libs 1 0)
	)
	cmake_src_configure
}

src_install() {
	local LIB_TYPE=$(usex static-libs a so)
	doheader lshpack.h
	dolib.${LIB_TYPE} "${BUILD_DIR}"/libls-hpack.${LIB_TYPE}
	einstalldocs
}
