# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="LiteSpeed QUIC (LSQUIC) Library"
HOMEPAGE="https://github.com/litespeedtech/lsquic/"
EGIT_REPO_URI="https://github.com/litespeedtech/lsquic/"
EGIT_COMMIT="3bbf683f25ab84826951350c57ae226c88c54422"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs"

DEPEND="
	dev-libs/boringssl-fips:=[static-libs=]
"

PATCHES=(
	"${FILESDIR}"/disable-${PN}-build-deps-libs.patch
	"${FILESDIR}"/fix-${PN}-boringssl-not-found.patch
)

src_configure() {
	local mycmakeargs=(
		-DLSQUIC_SHARED_LIB=$(usex !static-libs)
		-DBORINGSSL_DIR=/usr
		-DBORINGSSL_LIB_ssl=ssl
		-DBORINGSSL_LIB_crypto=crypto
	)
	cmake_src_configure
}

pkg_preinst() {
	mkdir -p ${D}/usr/include/liblsquic/
	cp -a ${S}/src/liblsquic/lsquic_logger.h ${D}/usr/include/liblsquic/
	cp -a ${S}/src/liblsquic/lsquic_stock_shi.h ${D}/usr/include/liblsquic/
	cp -a ${S}/src/liblsquic/lsquic_shared_support.h ${D}/usr/include/
}
