# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 virtualx

DESCRIPTION="A cross platform utility library for ModernGL"
HOMEPAGE="https://github.com/moderngl/moderngl-window https://pypi.org/project/moderngl-window"
SRC_URI="https://github.com/moderngl/moderngl-window/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples"

NEEDED_FOR_TESTS_AND_RUN="
	>dev-python/numpy-1.16[${PYTHON_USEDEP}]
	>=dev-python/PyWavefront-1.2.0[${PYTHON_USEDEP}]
	<dev-python/PyWavefront-2[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.3.2[${PYTHON_USEDEP}]
	>=dev-python/trimesh-3.2.6[${PYTHON_USEDEP}]
"

RDEPEND="
	dev-python/glfw[${PYTHON_USEDEP}]
	dev-python/imgui[glfw,sdl,opengl,${PYTHON_USEDEP}]
	<dev-python/moderngl-6[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	>=dev-python/pygame-2.0.1[${PYTHON_USEDEP}]
	dev-python/pyglet[${PYTHON_USEDEP}]
	>=dev-python/pyopengl-3.1.0[${PYTHON_USEDEP},tk]
	<dev-python/PyQt5-6[${PYTHON_USEDEP}]
	>=dev-python/pyrr-0.10[${PYTHON_USEDEP}]
	<dev-python/PySDL2-1[${PYTHON_USEDEP}]
	<dev-python/pyside2-6[${PYTHON_USEDEP}]
	${NEEDED_FOR_TESTS_AND_RUN}
"

BDEPEND="
	test? (
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/glcontext[${PYTHON_USEDEP}]
		${NEEDED_FOR_TESTS_AND_RUN}
	)
	doc? (
		<dev-python/moderngl-6[${PYTHON_USEDEP}]
		>dev-python/numpy-1.16[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		>=dev-python/pyrr-0.10[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]
	)
"

DEPEND="${RDEPEND}"

python_compile_all() {
	if use doc; then
		find "${S}/docs" -type f -exec sed -i 's/sphinxcontrib.napoleon/sphinx\.ext\.napoleon/g' {} \;
		emake man -C docs
	fi
}

python_install_all() {
	distutils-r1_python_install_all
	use doc && doman "${S}/docs/_build/man/${PN}.1"
	if use examples; then
        dodoc -r examples
        docompress -x /usr/share/doc/${PF}/examples
    fi
}

distutils_enable_tests pytest
src_test() {
	virtx distutils-r1_src_test
}
