# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# required because of manual install in src_install
CMAKE_MAKEFILE_GENERATOR="emake"

PYTHON_COMPAT=( python3_{10..11} )

inherit cmake python-any-r1 optfeature toolchain-funcs

DESCRIPTION="header-only C++ library for numerical analysis with multi-dimensional arrays"
HOMEPAGE="https://github.com/xtensor-stack/xtensor"
SRC_URI="https://codeload.github.com/xtensor-stack/${PN}/tar.gz/refs/tags/${PV} -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc openmp tbb test xsimd"

DEPEND="
	dev-cpp/xtl
	tbb? ( dev-cpp/tbb )
	xsimd? ( dev-cpp/xsimd )
"
RDEPEND="${DEPEND}"
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
REQUIRED_USE="?? ( tbb openmp )"

python_check_deps() {
	python_has_version \
		"dev-python/breathe[${PYTHON_USEDEP}]" \
		"dev-python/sphinx[${PYTHON_USEDEP}]" \
		"dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]"
}

pkg_pretend() {
	use openmp && tc-check-openmp
}

pkg_setup() {
	use openmp && tc-check-openmp
	use doc && python-any-r1_pkg_setup
}

src_prepare() {
	# Skipping test due to https://github.com/xtensor-stack/xtensor/issues/2653
	sed -i -e '/test_xoptional\.cpp/d' test/CMakeLists.txt || die

	# Current version of xsimd in tree is 11.1.0 (announcing itself as 11.0.1)
	# Version appears to be compatible (compiles & tests succeed)
	sed -i -e 's/xsimd_REQUIRED_VERSION 10.0.0/xsimd_REQUIRED_VERSION 11.0.1/' \
		CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS=$(usex test)
		-DXTENSOR_USE_OPENMP=$(usex openmp)
		-DXTENSOR_USE_TBB=$(usex tbb)
		-DXTENSOR_USE_XSIMD=$(usex xsimd)
	)

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

pkg_postinst() {
	optfeature "JSON support" dev-cpp/nlohmann_json
}
