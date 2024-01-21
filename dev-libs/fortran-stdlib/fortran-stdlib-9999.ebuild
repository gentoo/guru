# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FORTRAN_STANDARD="2003"
PYTHON_COMPAT=( python3_{10..11} )

inherit cmake fortran-2 git-r3 python-any-r1

EGIT_REPO_URI="https://github.com/fortran-lang/stdlib.git"

DESCRIPTION="A community driven standard library for (modern) Fortran"
HOMEPAGE="https://stdlib.fortran-lang.org/"

LICENSE="MIT"
SLOT="0"
IUSE="doc test"
RESTRICT="mirror !test? ( test )"

DEPEND="
	${PYTHON_DEPS}
	$(python_gen_any_dep '
		dev-build/fypp[${PYTHON_USEDEP}]
	')
	doc? (
		$(python_gen_any_dep '
			app-text/ford[${PYTHON_USEDEP}]
		')
	)
	test? ( dev-util/fortran-test-drive )
"

pkg_setup() {
	fortran-2_pkg_setup
}

src_prepare() {
	default

	# Remove Fortran compiler version from paths
	sed -i -e "s:/\${CMAKE_Fortran_COMPILER_ID}-\${CMAKE_Fortran_COMPILER_VERSION}::" config/CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs+=(
		-DBUILD_SHARED_LIBS=on
		-DBUILD_TESTING=$(usex test)
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile

	if use doc ; then
		einfo "Build API documentation:"
		${EPYTHON} ford API-doc-FORD-file.md || die
	fi
}

src_test() {
	LD_LIBRARY_PATH="${BUILD_DIR}/src:${BUILD_DIR}/src/tests/hash_functions" cmake_src_test
}

src_install() {
	cmake_src_install

	use doc && HTML_DOCS=( "${WORKDIR}/${P}"/API-doc/. )
	einstalldocs
}
