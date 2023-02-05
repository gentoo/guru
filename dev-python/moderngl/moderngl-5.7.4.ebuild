# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Modern OpenGL binding for python"
HOMEPAGE="https://github.com/moderngl/moderngl https://pypi.org/project/moderngl"
SRC_URI="https://github.com/moderngl/moderngl/archive/refs/tags/${PV}.tar.gz -> v${PV}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=""
BDEPEND="
	x11-libs/libX11
	media-libs/libglvnd[X]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	test? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		dev-python/pycodestyle[${PYTHON_USEDEP}]
		dev-python/glcontext[${PYTHON_USEDEP}]
	 )
"
DEPEND="${BDEPEND}"

# Tests are deactivated because we cannot open display
# distutils_enable_tests pytest
# python_test() {
#     cd "${T}" || die
#     epytest "${S}"/tests
# }

pkg_postinst() {
	use test && ewarn The tests for this package are deactivated because the test display can not be opened.
	use test && ewarn If you know how to solve this issue, please do so.
}
