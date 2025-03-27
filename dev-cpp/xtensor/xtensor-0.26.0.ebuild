# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit cmake python-any-r1 optfeature toolchain-funcs

DESCRIPTION="header-only C++ library for numerical analysis with multi-dimensional arrays"
HOMEPAGE="https://github.com/xtensor-stack/xtensor"
SRC_URI="https://codeload.github.com/xtensor-stack/${PN}/tar.gz/refs/tags/${PV} -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc openmp tbb test"

DEPEND="
	>=dev-cpp/xtl-0.8.0
	tbb? ( dev-cpp/tbb )
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

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS=$(usex test)
		-DXTENSOR_USE_OPENMP=$(usex openmp)
		-DXTENSOR_USE_TBB=$(usex tbb)
		# A specific verions of dev-cpp/xsimd is needed, so it requires ongoing maintenance.
		-DXTENSOR_USE_XSIMD=OFF
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	use doc && emake -C docs html
}

src_install() {
	use doc && HTML_DOCS=( docs/build/html/* )
	cmake_src_install
}

pkg_postinst() {
	optfeature "JSON support" dev-cpp/nlohmann_json
}
