# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="sphinx"
DOCS_DIR="docs"
DOCS_DEPEND="
	dev-python/furo
	dev-python/sphinx-copybutton
"

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 virtualx docs

DESCRIPTION="Modern OpenGL binding for python"
HOMEPAGE="https://github.com/moderngl/moderngl https://pypi.org/project/moderngl"
SRC_URI="https://github.com/moderngl/moderngl/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"
# All tests fails because they cannot access the video card
# see https://forums.gentoo.org/viewtopic.php?p=8843999
RESTRICT="test"

BDEPEND="
	media-libs/libglvnd[X]
	>=dev-python/glcontext-3.0.0[${PYTHON_USEDEP}]
	test? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		dev-python/pycodestyle[${PYTHON_USEDEP}]
		dev-python/pyopengl[${PYTHON_USEDEP}]
	)
"
DEPEND="${BDEPEND}"

EPYTEST_DESELECT=(
	# Make sure we are not using the system-wide install
	"tests/test_local.py"
)
distutils_enable_tests pytest
src_test() {
	rm -rf "${S}/${PN}"
	virtx distutils-r1_src_test
}
