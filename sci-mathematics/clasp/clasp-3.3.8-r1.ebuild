# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake edo flag-o-matic

DESCRIPTION="A conflict-driven nogood learning answer set solver"
HOMEPAGE="
	https://github.com/potassco/clasp
	https://www.cs.uni-potsdam.de/clasp/
"
SRC_URI="https://github.com/potassco/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples test +threads +tools"

RDEPEND="sci-libs/libpotassco:="
DEPEND="
	${RDEPEND}
	test? ( dev-cpp/catch:0 )
"

RESTRICT="!test? ( test )"
PATCHES=( "${FILESDIR}/${PN}-manpage.patch" )

src_prepare() {
	append-cxxflags "-I/usr/include/catch2"
	edo rm tests/catch.hpp
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCLASP_BUILD_APP=$(usex tools)
		-DCLASP_BUILD_EXAMPLES=$(usex examples)
		-DCLASP_BUILD_TESTS=$(usex test)
		-DCLASP_BUILD_WITH_THREADS=$(usex threads)

		-DCLASP_BUILD_STATIC=OFF
		-DCLASP_INSTALL_LIB=ON
		-DCLASP_INSTALL_VERSIONED=OFF
		-DCLASP_USE_LOCAL_LIB_POTASSCO=OFF
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	doman clasp.1
	dodoc README.md CHANGES
}
