# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="QPACK compression library for use with HTTP/3"
HOMEPAGE="https://github.com/litespeedtech/ls-qpack/"
SRC_URI="https://github.com/litespeedtech/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="static-libs test tools"
RESTRICT="!test? ( test )"

PATCHES=(
	"${FILESDIR}/${P}-fix-rpath.patch"
)

src_prepare() {
	cmake_src_prepare
	# fix test cases path
	sed -i "s|\.\./\.\.|${S}|" test/test_dyn_table_cap_mismatch.c || die
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=$(usex !static-libs)
		-DLSQPACK_BIN=$(usex tools)
		-DLSQPACK_TESTS=$(usex test)
	)
	cmake_src_configure
}
