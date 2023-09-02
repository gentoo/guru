# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 virtualx

DESCRIPTION="Modern OpenGL binding for python"
HOMEPAGE="https://github.com/moderngl/moderngl https://pypi.org/project/moderngl"
SRC_URI="https://github.com/moderngl/moderngl/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"
RESTRICT="test"
# The tests need moderngl compiled AND installed, otherwise they fail

BDEPEND="
	x11-libs/libX11
	media-libs/mesa
	>=dev-python/glcontext-2.3.6[${PYTHON_USEDEP}]
	<dev-python/glcontext-3[${PYTHON_USEDEP}]
	test? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		dev-python/pycodestyle[${PYTHON_USEDEP}]
	)
	doc? (
		dev-python/furo[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinx-copybutton[${PYTHON_USEDEP}]
	)
"
DEPEND="${BDEPEND}"

# distutils_enable_tests pytest
distutils_enable_sphinx docs

src_test() {
	virtx distutils-r1_src_test
}

pkg_postinst() {
	use doc && elog "The documentation is installed as html pages"
}
