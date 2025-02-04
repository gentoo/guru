# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="sphinx"
DOCS_DIR="docs"
DOCS_DEPEND="
	dev-python/moderngl
	dev-python/sphinx-rtd-theme
"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 virtualx docs optfeature

DESCRIPTION="A cross platform utility library for ModernGL"
HOMEPAGE="https://github.com/moderngl/moderngl-window https://pypi.org/project/moderngl-window"
SRC_URI="https://github.com/moderngl/moderngl-window/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	<dev-python/moderngl-6[${PYTHON_USEDEP}]
	>=dev-python/pillow-10.0.1[${PYTHON_USEDEP}]
	>=dev-python/pyglet-2.0.0[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	>=dev-python/pyglm-2.7.0[${PYTHON_USEDEP}]
	<dev-python/pyglm-3[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/glcontext[${PYTHON_USEDEP}]
		>=dev-python/pywavefront-1.2.0[${PYTHON_USEDEP}]
		<dev-python/pywavefront-2[${PYTHON_USEDEP}]
		>=dev-python/trimesh-3.2.6[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
src_test() {
	virtx distutils-r1_src_test
}

python_install_all() {
	distutils-r1_python_install_all
	if use doc; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}

pkg_postinst() {
	optfeature "supporting pygame as backend" dev-python/pygame
	optfeature "supporting pysdl2 as backend" dev-python/pysdl2
	optfeature "supporting GLFW as backend" dev-python/glfw
	optfeature "supporting QT5 as backend" dev-python/pyqt5
	optfeature "supporting PySide as backend" dev-python/pyside
}
