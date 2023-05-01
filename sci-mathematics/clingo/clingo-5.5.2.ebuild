# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{3..4} )
PYTHON_COMPAT=( python3_{10..11} ) # IDK how to pass pypy3

inherit cmake flag-o-matic lua-single python-single-r1 toolchain-funcs

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
	>=sci-mathematics/clasp-3.3.8:=[tools]
	sci-libs/libpotassco:=
	lua? ( ${LUA_DEPS} )
	python? ( ${PYTHON_DEPS} )
"
DEPEND="
	${RDEPEND}
	test? ( dev-cpp/catch:0  )
"
BDEPEND="
	>=dev-util/re2c-0.13.5
	>=sys-devel/bison-2.5
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}/${P}-system-catch.patch" )
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
	rm libreify/tests/catch.hpp || die
	rm libclingo/tests/catch.hpp || die
	rm libgringo/tests/catch.hpp || die
	cmake_src_prepare
}

src_configure() {
	append-cxxflags "-I/usr/include/catch2"
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
		-DCLINGO_USE_LOCAL_CLASP=OFF
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
