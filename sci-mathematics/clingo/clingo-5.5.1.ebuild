# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{3..4} )
PYTHON_COMPAT=( python3_{8..10} ) # IDK how to pass pypy3

inherit cmake lua-single python-single-r1 toolchain-funcs

DESCRIPTION="Integrated grounder and solver for answer set logic programs"
HOMEPAGE="
	https://github.com/potassco/clingo
	https://potassco.org/clingo
"
SRC_URI="https://github.com/potassco/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="examples lua python test +tools"

RDEPEND="
	sci-mathematics/clasp:=[tools]
	sci-mathematics/libpotassco:=
	lua? ( ${LUA_DEPS} )
	python? ( ${PYTHON_DEPS} )
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-util/re2c-0.13.5
	>=sys-devel/bison-2.5
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}/${P}-system-clasp.patch" )
RESTRICT="!test? ( test )"
REQUIRED_USE="
	lua? ( ${LUA_REQUIRED_USE} )
	python? ( ${PYTHON_REQUIRED_USE} )
"

pkg_setup() {
	use lua && lua-single_pkg_setup
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	rm -r clasp || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCLINGO_BUILD_APPS=$(usex tools)
		-DCLINGO_BUILD_EXAMPLES=$(usex examples)
		-DCLINGO_BUILD_TESTS=$(usex test)
		-DCLINGO_BUILD_WITH_LUA=$(usex lua)
		-DCLINGO_BUILD_WITH_PYTHON=$(usex python)

		-DCLINGO_BUILD_STATIC=OFF
		-DCLINGO_BUILD_WEB=OFF
		-DCLINGO_CMAKE_AR="$(tc-getAR)"
		-DCLINGO_CMAKE_RANLIB="$(tc-getRANLIB)"
		-DCLINGO_INSTALL_LIB=ON
		-DCLINGO_USE_LIB=OFF
	)
	if use lua; then
		mycmakeargs+=( "-DCLINGO_LUA_VERSION:LIST=$(lua_get_version);EXACT" )
		mycmakeargs+=( "-DLUACLINGO_INSTALL_DIR=$(lua_get_cmod_dir)" )
	fi
	if use python; then
		local pyversion="${EPYTHON/python/}"
		mycmakeargs+=( "-DCLINGO_PYTHON_VERSION:LIST=${pyversion};EXACT" )
		mycmakeargs+=( "-DPYCLINGO_INSTALL_DIR=$(python_get_sitedir)" )
	fi
	cmake_src_configure
}
