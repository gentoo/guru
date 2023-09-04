# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

IMGUI_VERSION="1.82" # The version of imgui that pyimgui is using

DESCRIPTION="Cython-based Python bindings for dear imgui"
HOMEPAGE="https://github.com/pyimgui/pyimgui https://pypi.org/project/imgui"
SRC_URI="
	https://github.com/pyimgui/pyimgui/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/ocornut/imgui/archive/v${IMGUI_VERSION}.tar.gz -> imgui-${IMGUI_VERSION}.gh.tar.gz
"
S="${WORKDIR}/pyimgui-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="allegro glfw glut opengl sdl vulkan doc"

RDEPEND="media-libs/imgui[bindings,allegro?,glfw?,glut?,opengl?,sdl?,vulkan?]"
BDEPEND="
	<dev-python/cython-3[${PYTHON_USEDEP}]
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/pyopengl[${PYTHON_USEDEP}]
		~dev-python/pypandoc-1.4[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
	)
"

src_unpack() {
	default
	rm -r "${S}/imgui-cpp"
	mv "${WORKDIR}/imgui-${IMGUI_VERSION}" "${S}/imgui-cpp"
}

distutils_enable_tests pytest

python_compile_all() {
	use doc && emake man -C "${S}/doc"
	use test && rm -rf "${S}/${PN}"
}

python_install_all() {
	distutils-r1_python_install_all
	use doc && doman "${S}/doc/build/man/pyimgui.1"
}

python_test() {
	epytest "${S}/tests" || die "Tests failed with ${EPYTHON}"
}
