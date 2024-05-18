# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

BORINGSSL_COMMIT="15655052e8701f908937204785eaa8cd4363099f"

DESCRIPTION="LiteSpeed QUIC (LSQUIC) Library"
HOMEPAGE="https://github.com/litespeedtech/lsquic/"
SRC_URI="
	https://github.com/litespeedtech/lsquic/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/google/boringssl/archive/${BORINGSSL_COMMIT}.tar.gz -> boringssl-fips-20230428.tar.gz
"

S="${WORKDIR}/lsquic-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="static-libs test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-lang/go
	dev-libs/ls-qpack:=[static-libs=]
	dev-libs/ls-hpack:=[static-libs=]
"

PATCHES=(
	"${FILESDIR}"/${PN}-disable-build-deps-libs.patch
	"${FILESDIR}"/${PN}-link-boringssl-static-libs.patch
	"${FILESDIR}"/${PN}-disable-override-flags.patch
	"${FILESDIR}"/${PN}-disable-boring-override-flags.patch
)

src_unpack() {
	unpack ${P}.tar.gz
	unpack boringssl-fips-20230428.tar.gz
	mv boringssl-${BORINGSSL_COMMIT} "${S}"/src/liblsquic/boringssl || die
}

src_configure() {
	local mycmakeargs=(
		-DLSQUIC_SHARED_LIB=$(usex !static-libs)
		-DLSQUIC_TESTS=$(usex test)
	)
	cmake_src_configure
}
