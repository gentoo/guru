# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake fortran-2

COMMIT="bdd9118a6e4af9245640ccb58b4f49cbf5aaa899"

DESCRIPTION="Profiling API for adding external tool instrumentation support to any project"
HOMEPAGE="https://github.com/khuck/perfstubs"
SRC_URI="https://github.com/khuck/${PN}/archive/${COMMIT}.tar.gz -> ${PF}.gh.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+default examples +timers tools"

pkg_setup() {
	fortran-2_pkg_setup
}

src_prepare() {
	sed \
		-e "s|/lib|/$(get_libdir)|g" \
		-e "s|DESTINATION lib|DESTINATION $(get_libdir)|g" \
		-i CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DPERFSTUBS_USE_STATIC=OFF

		-DPERFSTUBS_BUILD_EXAMPLES=$(usex examples)
		-DPERFSTUBS_BUILD_MULTI_TOOL=$(usex tools)
		-DPERFSTUBS_USE_DEFAULT_IMPLEMENTATION=$(usex default)
		-DPERFSTUBS_USE_TIMERS=$(usex timers)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	dodoc README.md
}
