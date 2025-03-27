# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

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
	cmake_src_compile
	use doc && emake -C docs html
}

src_install() {
	use doc && HTML_DOCS=( docs/build/html/* )
	cmake_src_install
}
