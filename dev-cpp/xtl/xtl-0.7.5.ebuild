# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# required because of manual install in src_install
CMAKE_MAKEFILE_GENERATOR="emake"

PYTHON_COMPAT=( python3_{10..11} )

inherit cmake python-any-r1

DESCRIPTION="Algorithms and containers used by the xtensor stack and the xeus stack"
HOMEPAGE="https://github.com/xtensor-stack/xtl"
SRC_URI="https://codeload.github.com/xtensor-stack/${PN}/tar.gz/refs/tags/${PV} -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc test"

BDEPEND="
	doc? (
		app-text/doxygen
		$(python_gen_any_dep '
			dev-python/breathe[${PYTHON_USEDEP}]
			dev-python/sphinx[${PYTHON_USEDEP}]
			dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]
		')
	)
	test? ( dev-cpp/doctest )
"

RESTRICT="!test? ( test )"

python_check_deps() {
	python_has_version \
		"dev-python/breathe[${PYTHON_USEDEP}]" \
		"dev-python/sphinx[${PYTHON_USEDEP}]" \
		"dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]"
}

pkg_setup() {
	use doc && python-any-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=( -DBUILD_TESTS=$(usex test) )

	cmake_src_configure
}

src_compile() {
	if use doc; then
		cd "${WORKDIR}/${P}/docs" || die
		emake html BUILDDIR="${BUILD_DIR}"
		HTML_DOCS=( "${BUILD_DIR}/html/." )
	fi
}

src_test() {
	cmake_src_compile xtest
}

src_install() {
	# Default install target depends on tests with USE=test enabled.
	# However, this is a header-only library.
	DESTDIR="${D}" cmake_build install/fast "$@"

	einstalldocs
}
