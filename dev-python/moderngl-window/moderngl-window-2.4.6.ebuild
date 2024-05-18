# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="sphinx"
DOCS_DIR="docs"
DOCS_DEPEND="
	dev-python/moderngl
	dev-python/sphinx-rtd-theme
"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 virtualx docs

DESCRIPTION="A cross platform utility library for ModernGL"
HOMEPAGE="https://github.com/moderngl/moderngl-window https://pypi.org/project/moderngl-window"
SRC_URI="https://github.com/moderngl/moderngl-window/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

RDEPEND="
	<dev-python/moderngl-6[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pyglet[${PYTHON_USEDEP}]
	>=dev-python/pyrr-0.10[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/glcontext[${PYTHON_USEDEP}]
		>=dev-python/PyWavefront-1.2.0[${PYTHON_USEDEP}]
		<dev-python/PyWavefront-2[${PYTHON_USEDEP}]
		>=dev-python/trimesh-3.2.6[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}"

python_install_all() {
	default
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}

distutils_enable_tests pytest
src_test() {
	virtx distutils-r1_src_test
}
